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
			end
		end
	end
end
