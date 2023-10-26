module Resources
  module V1
    class Root < Grape::API
      version 'v1'
      format :json
      content_type :json, 'application/json'

      before {
        authenticate! unless route.settings[:auth] && route.settings[:auth][:disabled]
      }

      helpers ::Helpers::V1::Helpers
  
      mount Resources::V1::Aaa
      mount Resources::V1::Login
      mount Resources::V1::Logout
    end
  end
end