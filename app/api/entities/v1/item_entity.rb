module Entities
  module V1
    class ItemEntity < Grape::Entity
      class Item < Grape::Entity
        expose :id
        expose :category_name do |item|
          item.item_category.name
        end
        expose :name
        expose :item_code
        expose :price
        expose :quantity
      end

      class Items < Grape::Entity
        expose :current_page
        expose :total_pages
        expose :items, using: Item
      end

      class Categories < Grape::Entity
        expose :id
        expose :name
      end

      class ItemCode < Grape::Entity
        expose :item_code
      end
    end
  end
end