class UserHistory < ApplicationRecord
  belongs_to :user

  def login_history(token)
    self.token = token
    self.login_time = Time.zone.now
    self.save!
  end
end
