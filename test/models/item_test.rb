# == Schema Information
#
# Table name: items
#
#  id               :bigint           not null, primary key
#  item_code        :string(255)      not null
#  name             :string(255)      not null
#  price            :decimal(50, 2)   not null
#  quantity         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  item_category_id :bigint           not null
#
# Indexes
#
#  index_items_on_item_category_id  (item_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (item_category_id => item_categories.id)
#
require "test_helper"

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
