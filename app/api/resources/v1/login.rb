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
          user = User.find_by(login_id: params[:login_id])
          token = create_token(user)
          user.login(token)
          data = {
            name: user.full_name,
            company_name: user.company.name,
            token: token,
            authority: user.user_authority_id
          }

          present data, with: Entities::V1::LoginEntity

        rescue ActiveRecord::RecordInvalid => e
          conflict_error(I18n.t('error_message.failed_to_save'))
        end
      end
    end
  end
end
