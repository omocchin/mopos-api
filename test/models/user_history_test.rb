# == Schema Information
#
# Table name: user_histories
#
#  id          :bigint           not null, primary key
#  login_time  :datetime
#  logout_time :datetime
#  token       :string(500)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_user_histories_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class UserHistoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
