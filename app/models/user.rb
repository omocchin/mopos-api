# == Schema Information
#
# Table name: users
#
#  id                                  :bigint           not null, primary key
#  email                               :string(255)
#  first_name                          :string(255)      not null
#  last_name                           :string(255)      not null
#  password_digest                     :string(255)      not null
#  status(0: logged-out, 1: logged-in) :integer          default("logged_out"), not null
#  tel                                 :string(255)
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  company_id                          :bigint           not null
#  login_id                            :string(255)      not null
#  user_authority_id                   :bigint           not null
#
# Indexes
#
#  index_users_on_company_id         (company_id)
#  index_users_on_user_authority_id  (user_authority_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_authority_id => user_authorities.id)
#
class User < ApplicationRecord
  has_secure_password

  belongs_to :company
  belongs_to :user_authority
  has_many :user_histories, dependent: :destroy

  enum :status, { logged_out: 0, logged_in: 1 }

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def login(token)
    self.status = User.statuses[:logged_in]
    self.user_histories.new.login_history(token)
    self.save!
  end

  def logout
    self.status = User.statuses[:logged_out]
    self.user_histories.last.logout_history
    self.save!
  end
end
