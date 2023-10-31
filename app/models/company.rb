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
  has_secure_password

  has_many :company_histories, dependent: :destroy

  enum :status, { logged_out: 0, logged_in: 1 }

  def login(token)
    self.status = Company.statuses[:logged_in]
    self.company_histories.new.login_history(token)
    self.save!
  end
end
