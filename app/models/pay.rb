# == Schema Information
#
# Table name: pays
#
#  id          :bigint           not null, primary key
#  hourly_rate :float(24)        not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_pays_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Pay < ApplicationRecord
  belongs_to :user
  has_many :user_shifts
end
