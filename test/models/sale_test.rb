# == Schema Information
#
# Table name: sales
#
#  id         :bigint           not null, primary key
#  subtotal   :decimal(50, 2)   not null
#  tax        :string(255)
#  tax_total  :decimal(50, 2)   not null
#  total      :decimal(50, 2)   not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#  unique_id  :string(255)      not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_sales_on_company_id  (company_id)
#  index_sales_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class SaleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
