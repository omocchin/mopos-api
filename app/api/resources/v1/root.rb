module Resources
  module V1
    class Root < Grape::API
      version 'v1'
      format :json
      content_type :json, 'application/json'

      before {
        company_authenticate! unless route.settings[:company_auth] && route.settings[:company_auth][:disabled]
        user_authenticate! unless route.settings[:user_auth] && route.settings[:user_auth][:disabled]
      }

      helpers ::Helpers::V1::Helpers
  
      mount Resources::V1::Aaa
      mount Resources::V1::Login
      mount Resources::V1::Logout
      mount Resources::V1::User
      mount Resources::V1::CompanyUser
    end
  end
end