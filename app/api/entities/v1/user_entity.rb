module Entities
  module V1
    class UserEntity < Grape::Entity
      expose :name
    end
  end
end