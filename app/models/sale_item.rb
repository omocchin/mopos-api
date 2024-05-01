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
class SaleItem < ApplicationRecord
  belongs_to :item
  belongs_to :sale

  def self.checkout_sale_items(sale_id, items)
    items.each do |checkout_item|
      item = Item.find_by(item_code: checkout_item[:item_code])
      SaleItem.create(
        sale_id: sale_id,
        item_id: item.id,
        price: checkout_item[:price],
        quantity: checkout_item[:buy_quantity]
      )
    end
  end
end
