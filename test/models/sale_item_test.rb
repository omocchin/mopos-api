# == Schema Information
#
# Table name: sale_items
#
#  id                                :bigint           not null, primary key
#  price                             :decimal(50, 2)   not null
#  quantity(quantity of item bought) :integer
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  item_id                           :bigint           not null
#  sale_id                           :bigint           not null
#
# Indexes
#
#  index_sale_items_on_item_id  (item_id)
#  index_sale_items_on_sale_id  (sale_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (sale_id => sales.id)
#
require "test_helper"

class SaleItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
