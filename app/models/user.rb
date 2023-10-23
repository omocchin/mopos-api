class User < ApplicationRecord
  include ActiveModel::SecurePassword
  has_secure_password

  belongs_to :company
  belongs_to :user_authority

  def full_name
    self.first_name + self.last_name
  end
end
