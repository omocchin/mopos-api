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
    end
  end
end