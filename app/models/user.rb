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
  has_one :pay
  has_many :user_histories, dependent: :destroy
  has_many :user_shifts

  enum :status, { clocked_out: 0, clocked_in: 1 }

  scope :search_user, ->(keyword) { 
    where('first_name LIKE ?',  "%#{keyword}%")
    .or(where('last_name LIKE ?', "%#{keyword}%"))
    .or(where('user_number LIKE ?', "%#{keyword}%"))
  }

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def login(token)
    # self.status = User.statuses[:clocked_out]
    self.user_histories.new.login_history(token)
    self.save!
  end

  def logout
    # self.status = User.statuses[:clocked_in]
    self.user_histories.last.logout_history
    self.save!
  end

  def clock_in_out
    shift = self.user_shifts.last
    if !shift || shift.clock_out.present?
      self.user_shifts.create(pay_id: self.pay.id, clock_in: Time.zone.now)
      self.update(status: User.statuses[:clocked_in])
    else
      shift.update(clock_out: Time.zone.now)
      self.update(status: User.statuses[:clocked_out])
    end
    return shift
  end
end
