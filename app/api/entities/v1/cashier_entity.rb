module Entities
  module V1
    class CashierEntity < Grape::Entity
      class Categories < Grape::Entity
        expose :id
        expose :name
      end
      class CategoryItems < Grape::Entity
        expose :id
        expose :name
        expose :quantity
        expose :price
        expose :item_code
      end
      class PaymentTypes < Grape::Entity
        expose :id
        expose :name
      end
      class ReceiptTypes < Grape::Entity
        expose :id
        expose :name
      end
      class Checkout < Grape::Entity
        expose :id
      end
      class Sale < Grape::Entity
        expose :id
        expose :change do |sale|
          sale.sale_payment.change_amount
        end
        expose :payment_type do |sale|
          sale.sale_payment.payment_type.name
        end
      end
    end
  end
end