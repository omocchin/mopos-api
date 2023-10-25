module Resources
  module V1
    class Aaa < Grape::API
      resources :aaa do
        get do
          aaa = {
            name: 'kyle'
          }

          # present aaa, with: Entities::V1::UserEntity
        end
      end
    end
  end
end
