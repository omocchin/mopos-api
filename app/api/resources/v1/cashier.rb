module Resources
  module V1
    class Cashier < Grape::API
      resources :cashier do
        resources :categories do
          desc 'get company item categories'
          route_setting :user_auth, disabled: true
          get do
            categories = @company.item_categories
            present categories, with: Entities::V1::CashierEntity::Categories
          end
        end
        route_param :category do
          resources :items do
            desc 'get category items'
            route_setting :user_auth, disabled: true
            get do
              items = @company.item_categories.find_by(name: params[:category]).items
              present items, with: Entities::V1::CashierEntity::CategoryItems
            end
          end
        end
        resources :checkout do
          desc 'customer checkout'
          route_setting :user_auth, disabled: true
          params do
            requires :user_number, type: Integer
            requires :subtotal, type: BigDecimal
            requires :tax_total, type: BigDecimal
            requires :total, type: BigDecimal
            requires :receipt_type, type: Integer
            requires :payment_type, type: Integer
            requires :paid_amount, type: BigDecimal
            optional :change_amount, type: BigDecimal
            optional :tip_amount, type: BigDecimal
            optional :receipt_email, type: String
            requires :items, type: Array[JSON] do
              requires :id, type: Integer
              requires :name, type: String
              requires :price, type: BigDecimal
              requires :item_code, type: String
              requires :buy_quantity, type: Integer
              optional :quantity, type: Integer
            end
            optional :card_info, type: JSON do
              optional :name, type: String
              optional :number, type: String
              optional :security_code, type: String
              optional :expiry, type: String
            end
          end
          post do
            user = @company.users.find_by(user_number: params[:user_number])
            payment_type = PaymentType.find(params[:payment_type])
            sale = nil
            ActiveRecord::Base.transaction do
              sale = @company.sales.new.checkout(user, params)
              if payment_type.is_card_payment?
                response = create_order(params[:total], params[:card_info], @company.uuid_last)
                sale.sale_payment.add_payment_order_id(response['id'])
              end
            end

            present sale, with: Entities::V1::CashierEntity::Checkout
          rescue Exceptions::ClientError => e
            request_api_client_error(e.message, e.status)
          rescue Exceptions::ServerError => e
            request_api_server_error(e.message, e.status)
          end

          desc 'get payment type'
          route_setting :user_auth, disabled: true
          get :payment_type do
            payment_types = PaymentType.all
            present payment_types, with: Entities::V1::CashierEntity::PaymentTypes
          end

          desc 'get receipt type'
          route_setting :user_auth, disabled: true
          get :receipt_type do
            receipt_types = ReceiptType.all
            present receipt_types, with: Entities::V1::CashierEntity::ReceiptTypes
          end
        end
      end
    end
  end
end
