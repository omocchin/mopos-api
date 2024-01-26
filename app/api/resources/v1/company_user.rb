module Resources
	module V1
		class CompanyUser < Grape::API
			resources :company_user do
				desc 'create company user'
        route_setting :auth, disabled: true
				params do
					requires :name
          requires :email
          requires :tel
          requires :login_id
          requires :password
				end
				post :create_company do
          company = Company.create_company_user(params)
          status 201

				rescue ActiveRecord::RecordNotUnique => e
					conflict_error(I18n.t('error_message.duplicate_entree', model: 'login id'))
				end
			end
		end
	end
end
