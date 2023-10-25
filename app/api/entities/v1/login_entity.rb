module Entities
  module V1
    class LoginEntity < Grape::Entity
      expose :name
      expose :company_name
      expose :token
      expose :authority
    end
  end
end