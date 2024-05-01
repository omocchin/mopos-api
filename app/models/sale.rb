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
class Sale < ApplicationRecord
  belongs_to :company
  belongs_to :user
  has_many :sale_items, dependent: :nullify
  has_one :sale_payment, dependent: :nullify
  has_one :sale_receipt, dependent: :nullify

  def generate_sale_unique_id
    last_index = self.company.sales.last&.unique_id&.split('-')&.last || '1'
    receipt_unique_id = "#{self.company.uuid_last}-#{last_index}"
  end

  def checkout(user, checkout_info)
    self.update(
      user_id: user.id,
      unique_id: generate_sale_unique_id,
      subtotal: checkout_info[:subtotal],
      tax_total: checkout_info[:tax_total],
      total: checkout_info[:total],
      tax: self.company.setting.tax
    )
    SaleItem.checkout_sale_items(self.id, checkout_info[:items])
    SalePayment.checkout_sale_payment(self.id, checkout_info[:payment_type], checkout_info[:paid_amount])
    SaleReceipt.checkout_sale_receipt(self.company, self.id, checkout_info[:receipt_type], checkout_info[:receipt_email])
    self
  end
end
