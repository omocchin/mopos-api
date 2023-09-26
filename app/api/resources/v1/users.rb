module Resources
  module V1
    class Users < Grape::API
      resources :users do
        get do
          pp 'test'
        end
      end
    end
  end
end
