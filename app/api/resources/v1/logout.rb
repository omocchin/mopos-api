module Resources
  module V1
    class Logout < Grape::API
      resources :logout do
        desc 'Logout'
        post do
          @user.logout

          status 201
        end
      end
    end
  end
end
