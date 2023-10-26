# == Schema Information
#
# Table name: user_authorities
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UserAuthority < ApplicationRecord
end
