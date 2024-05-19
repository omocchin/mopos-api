# == Schema Information
#
# Table name: companies
#
#  id                                  :bigint           not null, primary key
#  company_uuid                        :string(255)      not null
#  email                               :string(255)      not null
#  name                                :string(255)      not null
#  password_digest                     :string(255)      not null
#  status(0: logged-out, 1: logged-in) :integer          default("logged_out"), not null
#  tel                                 :string(255)      not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  login_id                            :string(255)      not null
#
# Indexes
#
#  index_companies_on_login_id  (login_id) UNIQUE
#
class Company < ApplicationRecord
  include RandomGenerator
  has_secure_password

  has_many :company_histories, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :item_categories, dependent: :destroy
  has_many :items, dependent: :nullify
  has_many :sale_receipts, dependent: :destroy
  has_many :sales, dependent: :destroy
  has_one :setting, dependent: :destroy

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
      company_uuid = uuid unless Company.find_by(company_uuid: uuid).present? || Company.all.select { |comp| comp.uuid_last == uuid.split('-').last }.present?
    end
    user_info[:company_uuid] = company_uuid
    company =Company.create!(user_info)
    company.create_setting(service_charge_amount: nil, tax: 10)
    company
  end

  def token_available?(token)
    history = self.company_histories.find_by(token: token)
    raise Exceptions::TokenUnavailable if history.logout_time.present?
  end

  def uuid_last
    self.company_uuid.split('-').last
  end
end
