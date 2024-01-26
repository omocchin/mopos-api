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

      resources :company_logout do
        desc 'Company Logout'
        post do
          token = headers['Authorization'].split(' ').last
          ActiveRecord::Base.transaction do
            @company.logout(token)
          end

          status 201
        end
      end
    end
  end
end
