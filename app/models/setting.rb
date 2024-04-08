# == Schema Information
#
# Table name: settings
#
#  id                     :bigint           not null, primary key
#  service_charge_amount  :integer
#  tax                    :decimal(10, )
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :bigint           not null
#  service_charge_type_id :bigint           not null
#
# Indexes
#
#  index_settings_on_company_id              (company_id)
#  index_settings_on_service_charge_type_id  (service_charge_type_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (service_charge_type_id => service_charge_types.id)
#
class Setting < ApplicationRecord
  belongs_to :company
end
