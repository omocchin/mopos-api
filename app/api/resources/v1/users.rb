module Resources
  module V1
    class Users < Grape::API
      resources :users do
        get do
          aaa = {
            name: 'kyle'
          }

          present aaa, with: Entities::V1::UserEntity
        end
      end
    end
  end
end
