# == Schema Information
#
# Table name: payment_types
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class PaymentTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
