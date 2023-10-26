# == Schema Information
#
# Table name: service_charge_types
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class ServiceChargeTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
