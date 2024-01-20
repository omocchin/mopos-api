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
    end
  end
end