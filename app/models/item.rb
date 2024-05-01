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
class Item < ApplicationRecord
  belongs_to :item_category
  has_many :sale_items

  scope :search_item, ->(keyword) { 
    if keyword
      where('name LIKE ?',  "%#{keyword}%")
      .or(where('item_code LIKE ?', "%#{keyword}%"))
    end
  }

  def create_item(item_info)
    self.update!(
      name: item_info[:name],
      price: item_info[:price],
      item_code: item_info[:item_code],
      quantity: item_info[:quantity] ? item_info[:quantity] : nil
    )
  end

  def edit_item(item_info, category_id)
    self.update!(
      item_category_id: category_id,
      name: item_info[:name],
      price: item_info[:price],
      item_code: item_info[:item_code],
      quantity: item_info[:quantity] ? item_info[:quantity] : nil
    )
  end

  def self.generate_item_code(company_uuid)
    item_code = ''
    while item_code.empty? do
      random = [*'a'..'z', *0..9, *'A'..'Z'].shuffle[0..10].join
      generated_item_code = "#{company_uuid.split('-').last}-#{random}"
      item_code = generated_item_code unless Item.find_by(item_code: generated_item_code).present?
    end
    return item_code
  end
end
