module Resources
  module V1
    class Login < Grape::API
      resources :login do
        desc 'Login'
        route_setting :auth, disabled: true
        params do
          requires :login_id, type: String
          requires :password, type: String
        end
        post do
          user = User.find_by(login_id: params[:login_id])&.authenticate(params[:password])  
          raise Exceptions::UserNotFound unless user
          token = create_user_token(user)
          ActiveRecord::Base.transaction do
            user.login(token)
          end
          data = {
            name: user.full_name,
            token: token,
            authority: user.user_authority_id
          }

          present data, with: Entities::V1::LoginEntity::UserLogin

        rescue Exceptions::UserNotFound => e
          not_found_error(I18n.t('error_message.user_not_found'))
        rescue ActiveRecord::RecordInvalid => e
          conflict_error(I18n.t('error_message.failed_to_save'))
        end
      end

      resources :company_login do
        desc 'company login'
        route_setting :auth, disabled: true
        params do
          requires :login_id, type: String
          requires :password, type: String
        end
        post do
          company = Company.find_by(login_id: params[:login_id])&.authenticate(params[:password])
          raise Exceptions::CompanyNotFound unless company
          token = create_company_token(company)
          ActiveRecord::Base.transaction do
            company.login(token)
          end
          data = {
            company_name: company.name,
            token: token
          }

          present data, with: Entities::V1::LoginEntity::CompanyLogin

        rescue Exceptions::CompanyNotFound => e
          not_found_error(I18n.t('error_message.user_not_found'))
        rescue ActiveRecord::RecordInvalid => e
          conflict_error(I18n.t('error_message.failed_to_save'))
        end
      end
    end
  end
end
