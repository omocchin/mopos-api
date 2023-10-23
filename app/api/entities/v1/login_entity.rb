module Entities
  module V1
    class LoginEntity < Grape::Entity
      expose :name
      expose :company_name
      expose :token
      expose :aithority
    end
  end
end