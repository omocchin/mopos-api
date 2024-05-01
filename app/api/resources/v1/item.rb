module Resources
  module V1
    class Item < Grape::API
      resources :item do
        desc 'generate item code'
        get 'generate_code' do
          code = {
            item_code: ::Item.generate_item_code(@company.company_uuid)
          }
          present code, with: Entities::V1::ItemEntity::ItemCode
        end

        desc 'get item'
				params do
					requires :id, type: String
				end
				get ':id' do
					item = ::Item.find(params[:id])
          raise Exceptions::EntreeNotfound.new('Product not found', 'item') if item.item_category.company_id != @company.id

					present item, with: Entities::V1::ItemEntity::Item
        rescue Exceptions::EntreeNotfound => e
          not_found_error(I18n.t('error_message.record_not_found', model: e.model))
				rescue ActiveRecord::RecordNotFound => e
					not_found_error(I18n.t('error_message.record_not_found', model: 'User'))
				end

        desc 'create item'
        params do
          requires :name, type: String
          requires :category, type: String
          requires :item_code, type: String
          requires :price, type: BigDecimal
          optional :quantity, type: Integer
        end
        post do
          ActiveRecord::Base.transaction do
            items = @company.item_categories.flat_map{ |category| category.items }
					  raise Exceptions::DuplicateEntree.new('Product name already exists', 'name') if items.select{ |item| item.name == params[:name]}.present?
					  raise Exceptions::DuplicateEntree.new('Product code already exists', 'item_code') if items.select{ |item| item.item_code == params[:item_code]}.present?
            category = @company.item_categories.find_by(name: params[:category])
            if !category
              category = @company.item_categories.new
              category = category.create_category(params[:category])
            end
            new_item = category.items.new
            new_item.create_item(declared(params))
          end
          status 201
        rescue Exceptions::DuplicateEntree => e
					unprocessable_content_error(e.message, e.model)
				rescue ActiveRecord::RecordInvalid => e
					conflict_error(e.message)
        end

        desc 'edit item'
        params do
          requires :id, type: String
          optional :name, type: String
          optional :category, type: String
          optional :item_code, type: String
          optional :price, type: Float
          optional :quantity, type: Integer
        end
        put ':id' do
          item = ::Item.find(params[:id])
          raise Exceptions::EntreeNotfound.new('Product  not found', 'item') if item.item_category.company_id != @company.id
          items = @company.item_categories.flat_map{ |category| category.items }
          if params[:name]
            raise Exceptions::DuplicateEntree.new('Product name already exists', 'name') if items.select{ |item| item.name == params[:name] && item.id != params[:id].to_i }.present?
          end
          if params[:item_code]
            raise Exceptions::DuplicateEntree.new('Product code already exists', 'item_code') if items.select{ |item| item.item_code == params[:item_code] && item.id != params[:id].to_i }.present?
          end
          category = @company.item_categories.find_by(name: params[:category])
          ActiveRecord::Base.transaction do
            if !category
              category = @company.item_categories.new
              category = category.create_category(params[:category])
            end
            item.edit_item(declared(params), category.id)
          end
          status 201
        rescue Exceptions::DuplicateEntree => e
					unprocessable_content_error(e.message, e.model)
        rescue Exceptions::EntreeNotfound => e
          not_found_error(I18n.t('error_message.record_not_found', model: e.model))
				rescue ActiveRecord::RecordInvalid => e
					conflict_error(e.message)
        end
      end

      resources :items do
        desc 'get all items'
        params do
          requires :page, type: Integer
          requires :per_page, type: Integer
					optional :keyword, type: String
					optional :item_categories, type: String
        end
        get do
          items = @company.item_categories.search_categories(params[:item_categories]&.split(','))
          .flat_map { |category| category.items.search_item(params[:keyword]) }.sort_by { |item| item.id }
          items = Kaminari.paginate_array(items).page(params[:page]).per(params[:per_page])
          res = {
						current_page: items.current_page,
						total_pages: items.total_pages,
						items: items
					}
          present res, with: Entities::V1::ItemEntity::Items
        end

        resources :categories do
          desc 'get company item categories'
          get do
            categories = @company.item_categories
            present categories, with: Entities::V1::ItemEntity::Categories
          end
        end

        desc 'delete items'
				params do
					requires :ids, type: Array
				end
				delete do
					ActiveRecord::Base.transaction do
						items = ::Item.where(id: params[:ids])
						items.destroy_all
					end

					status 200
				end
      end
    end
  end
end
