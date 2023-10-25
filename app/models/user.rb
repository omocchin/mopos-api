class User < ApplicationRecord
  include ActiveModel::SecurePassword
  has_secure_password

  belongs_to :company
  belongs_to :user_authority

  enum :status, { logged_out: 0, logged_in: 1 }

  def full_name
    self.first_name + self.last_name
  end

  def login
    self.status = User.statuses[:logged_in]
  end
end
