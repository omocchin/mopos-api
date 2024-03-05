# == Schema Information
#
# Table name: item_categories
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#
# Indexes
#
#  index_item_categories_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class ItemCategory < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :company

  scope :search_categories, -> (category_id) {
    where(id: category_id) if category_id && !category_id.empty?
  }

  def create_category(name)
    self.update(name: name)
    self
  end
end
