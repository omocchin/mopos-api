module Entities
  module V1
    class UserEntity < Grape::Entity
      class ClockInOut < Grape::Entity
        expose :user_number
        expose :first_name
        expose :last_name
        expose :status
        expose :time
      end

      class User < Grape::Entity
        expose :id
        expose :first_name
        expose :last_name
        expose :user_number
        expose :status
        expose :authority do |user|
          user.user_authority.name
        end
        expose :pay do |user|
          user.pay.hourly_rate
        end
      end

      class Users < Grape::Entity
        expose :current_page
        expose :total_pages
        expose :users, using: User
      end

      class EditUser < Grape::Entity
        expose :first_name
        expose :last_name
        expose :login_id
        expose :user_authority_id
        expose :pay do |user|
          user.pay.hourly_rate
        end
        expose :email
        expose :tel
        expose :user_number
        expose :status
      end
    end
  end
end