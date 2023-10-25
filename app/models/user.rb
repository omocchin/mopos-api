class User < ApplicationRecord
  include ActiveModel::SecurePassword
  has_secure_password

  belongs_to :company
  belongs_to :user_authority
  has_many :user_histories, dependent: :destroy

  enum :status, { logged_out: 0, logged_in: 1 }

  def full_name
    self.first_name + self.last_name
  end

  def login(token)
    self.status = User.statuses[:logged_in]
    self.user_histories.new.login_history(token)
    self.save!
  end
end
