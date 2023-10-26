# == Schema Information
#
# Table name: service_charge_types
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ServiceChargeType < ApplicationRecord
end
