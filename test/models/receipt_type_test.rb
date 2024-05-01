# == Schema Information
#
# Table name: receipt_types
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class ReceiptTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
