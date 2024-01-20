# == Schema Information
#
# Table name: user_shifts
#
#  id         :bigint           not null, primary key
#  cloack_out :datetime
#  clock_in   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  pay_id     :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_shifts_on_pay_id   (pay_id)
#  index_user_shifts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (pay_id => pays.id)
#  fk_rails_...  (user_id => users.id)
#
class UserShift < ApplicationRecord
  belongs_to :pay
end
