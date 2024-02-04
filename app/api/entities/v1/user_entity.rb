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

      class Users < Grape::Entity
        expose :id
        expose :first_name
        expose :last_name
        expose :user_number
        expose :authority do |user|
          user.user_authority.name
        end
        expose :pay do |user|
          user.pay.hourly_rate
        end
      end
    end
  end
end