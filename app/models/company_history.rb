# == Schema Information
#
# Table name: company_histories
#
#  id          :bigint           not null, primary key
#  login_time  :datetime
#  logout_time :datetime
#  token       :string(500)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :bigint           not null
#
# Indexes
#
#  index_company_histories_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class CompanyHistory < ApplicationRecord
  belongs_to :company

  def login_history(token)
    self.token = token
    self.login_time = Time.zone.now
    self.save!
  end

  def logout_history
    self.logout_time = Time.zone.now
    self.save!
  end

  def current_token?(token)
    raise Exceptions::NotCurrentToken unless self.token == token
  end
end
