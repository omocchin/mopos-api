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
class UserHistory < ApplicationRecord
  belongs_to :user

  def login_history(token)
    self.token = token
    self.login_time = Time.zone.now
    self.save!
  end

  def current_token?(token)
    raise Exceptions::NotCurrentToken unless self.token == token
  end
end
