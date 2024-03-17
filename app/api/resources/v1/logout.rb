module Resources
  module V1
    class Logout < Grape::API
      resources :logout do
        desc 'Logout'
        post do
          tokens = request.headers['Authorization'].split(', ')
          user_token = tokens[1]&.split(' ')&.last
          ActiveRecord::Base.transaction do
            @user.logout(user_token)
          end

          status 201
        end
      end

      resources :company_logout do
        desc 'Company Logout'
        route_setting :user_auth, disabled: true
        post do
          tokens = request.headers['Authorization'].split(',')
          company_token = tokens[0]&.split(' ')&.last
          ActiveRecord::Base.transaction do
            @company.logout(company_token)
          end

          status 201
        end
      end
    end
  end
end
