module Entities
  module V1
    class CompanyUserEntity < Grape::Entity
      class Settings < Grape::Entity
        expose :id
        expose :company_id
        expose :service_charge_type_id
        expose :tax do |value|
          value.tax.to_f
        end
        expose :service_charge_amount
      end
    end
  end
end