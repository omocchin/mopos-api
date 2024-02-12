# == Schema Information
#
# Table name: companies
#
#  id                :bigint           not null, primary key
#  email             :string(255)      not null
#  name              :string(255)      not null
#  password_digest   :string(255)      not null
#  tel               :string(255)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  company_unique_id :string(255)      not null
#  login_id          :string(255)      not null
#
class Company < ApplicationRecord
  include RandomGenerator
  has_secure_password

  has_many :company_histories, dependent: :destroy
  has_many :users, dependent: :destroy

  enum :status, { logged_out: 0, logged_in: 1 }

  def login(token)
    self.status = Company.statuses[:logged_in]
    self.company_histories.new.login_history(token)
    self.save!
  end

  def logout(token)
    self.status = Company.statuses[:logged_out]
    self.company_histories.find_by(token: token).logout_history
    self.save!
  end

  def active_company_users
    self.users.select(:id, :user_number, :first_name, :last_name).map do |user|
      shift = user.user_shifts.last
      next if shift.blank? || shift.clock_out
      user
    end.compact
  end

  def self.create_company_user(user_info)
    company_uuid = ''
    while !company_uuid.present? do
      uuid = generate_uuid
      company_uuid = uuid unless Company.find_by(company_uuid: uuid).present?
    end
    user_info[:company_uuid] = company_uuid
    Company.create!(user_info)
  end
end
