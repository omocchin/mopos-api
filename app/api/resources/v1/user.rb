module Resources
	module V1
		class User < Grape::API
			resources :user do
				desc 'clock in'
				route_setting :user_auth, disabled: true
				params do
					requires :user_number
				end
				post :clock_in_out do
					user = @company.users.find_by!(user_number: params[:user_number])
					shift = user.clock_in_out

					data = {
						user_number: user.user_number,
						first_name: user.first_name,
						last_name: user.last_name,
						status: user.status,
						time: shift.clock_out.present? ? day_time(shift.clock_out) : day_time(shift.clock_in)
					}

					present data, with: Entities::V1::UserEntity::ClockInOut

				rescue ActiveRecord::RecordNotFound => e
					not_found_error(I18n.t('error_message.record_not_found', model: e.model))
				end

				desc 'authenticate user'
				route_setting :company_auth, disabled: true
				get :authenticate do
					status 200
				end

				desc "create user"
				params do
					requires :first_name, type: String
					requires :last_name, type: String
					requires :login_id, type: String
					requires :password, type: String
					requires :password_confirmation, type: String, same_as: { value: :password, message: 'Password not match'}
					requires :user_authority, type: Integer
					requires :pay, type: BigDecimal
					optional :user_number, type: Integer
					optional :email, type: String, regexp: /.+@.+/
					optional :tel, type: String
				end
				post :create do
					raise Exceptions::DuplicateEntree.new('Login ID is already taken', 'login_id') if ::User.find_by(login_id: params[:login_id])
					raise Exceptions::DuplicateEntree.new('User number is already taken', 'user_number') if ::User.find_by(user_number: params[:user_number])
					ActiveRecord::Base.transaction do
						user = @company.users.new
						user.create_user(declared(params))
					end
					status 201
				rescue Exceptions::DuplicateEntree => e
					unprocessable_content_error(e.message, e.model)
				rescue ActiveRecord::RecordInvalid => e
					conflict_error(e.message)
				end

				desc 'edit user'
				params do
					requires :id, type: String
					optional :first_name, type: String
					optional :last_name, type: String
					optional :login_id, type: String
					optional :password, type: String
					optional :password_confirmation, type: String, same_as: { value: :password, message: 'Password not match'}
					optional :user_authority, type: Integer
					optional :pay, type: BigDecimal
					optional :user_number, type: Integer
					optional :email, type: String, regexp: /.+@.+/
					optional :tel, type: String
				end
				put ':id' do
					if params[:login_id]
						raise Exceptions::DuplicateEntree.new('Login ID is already taken', 'login_id') if ::User.where.not(id: params[:id]).find_by(login_id: params[:login_id])
					end
					if params[:user_number]
						raise Exceptions::DuplicateEntree.new('User number is already taken', 'user_number') if ::User.where.not(id: params[:id]).find_by(user_number: params[:user_number])
					end
					ActiveRecord::Base.transaction do
						user = @company.users.find(params[:id])
						user.edit_user(declared(params))
					end
					status 201
				rescue Exceptions::DuplicateEntree => e
					unprocessable_content_error(e.message, e.model)
				rescue ActiveRecord::RecordInvalid => e
					conflict_error(e.message)
				end

				desc 'get user'
				params do
					requires :id, type: String
				end
				get ':id' do
					user = @company.users.find(params[:id])

					present user, with: Entities::V1::UserEntity::EditUser
				rescue ActiveRecord::RecordNotFound => e
					not_found_error(I18n.t('error_message.record_not_found', model: 'User'))
				end
			end

			resources :users do
				desc 'all users'
				params do
          requires :page, type: Integer
          requires :per_page, type: Integer
					optional :keyword, type: String
					optional :user_status, type: String
        end
				get do
					users = @company.users.page(params[:page]).per(params[:per_page])
					users = users.search_user(params[:keyword]) if params[:keyword]
					users = users.where(status: ::User.statuses[params[:user_status]]) if params[:user_status]
					res = {
						current_page: users.current_page,
						total_pages: users.total_pages,
						users: users
					}
					present res, with: Entities::V1::UserEntity::Users
				end

				desc 'delete users'
				params do
					requires :ids, type: Array
				end
				delete do
					ActiveRecord::Base.transaction do
						users = ::User.where(id: params[:ids])
						users.destroy_all
					end

					status 200
				end
			end
		end
	end
end
