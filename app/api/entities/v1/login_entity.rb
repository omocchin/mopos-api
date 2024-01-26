module Entities
  module V1
    class LoginEntity < Grape::Entity
      class CompanyLogin < Grape::Entity
        expose :company_id
        expose :company_name
        expose :token
        expose :active_users
      end

      class UserLogin < Grape::Entity
        expose :name
        expose :token
        expose :authority
      end
    end
  end
end