# == Schema Information
#
# Table name: items
#
#  id               :bigint           not null, primary key
#  name             :string(255)      not null
#  price            :decimal(10, )    not null
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
class Item < ApplicationRecord
end
