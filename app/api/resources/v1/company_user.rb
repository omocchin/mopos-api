module Resources
	module V1
		class CompanyUser < Grape::API
			resources :company_user do
				desc 'create company and user'
        route_setting :company_auth, disabled: true
				route_setting :user_auth, disabled: true
				params do
					requires :company_info, type: JSON do
						requires :name
						requires :email
						requires :tel
						requires :login_id
						requires :password
					end
					requires :user_info, type: JSON do
						requires :first_name, type: String
						requires :last_name, type: String
						requires :login_id, type: String
						requires :password, type: String
						requires :password_confirmation, type: String, same_as: { value: :password, message: 'Password not match'}
						requires :user_authority, type: Integer
						requires :pay, type: BigDecimal
					end
				end
				post :create_company_user do
					ActiveRecord::Base.transaction do
						company = Company.create_company(params[:company_info])
						user = company.users.new
						user.create_user(params[:user_info])
					end
          status 201

				rescue ActiveRecord::RecordInvalid => e
					conflict_error(e.message)
				rescue ActiveRecord::RecordNotUnique => e
					conflict_error(I18n.t('error_message.duplicate_entree', model: 'login id'))
				end

				desc 'authenticate company user'
				route_setting :user_auth, disabled: true
				get :authenticate do
					status 200
				end

				desc 'get company setting'
				route_setting :user_auth, disabled: true
				get :settings do
					settings = @company.setting
					
					present settings, with: Entities::V1::CompanyUserEntity::Settings
				end
			end
		end
	end
end
