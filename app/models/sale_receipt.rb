# == Schema Information
#
# Table name: sale_receipts
#
#  id              :bigint           not null, primary key
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  company_id      :bigint           not null
#  receipt_type_id :bigint           not null
#  sale_id         :bigint           not null
#
# Indexes
#
#  index_sale_receipts_on_company_id       (company_id)
#  index_sale_receipts_on_receipt_type_id  (receipt_type_id)
#  index_sale_receipts_on_sale_id          (sale_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (receipt_type_id => receipt_types.id)
#  fk_rails_...  (sale_id => sales.id)
#
class SaleReceipt < ApplicationRecord
  belongs_to :sale
  belongs_to :receipt_type
  belongs_to :company

  def self.checkout_sale_receipt(company, sale_id, receipt_type_id, email)
    receipt_type = ReceiptType.find(receipt_type_id)
    SaleReceipt.create(
      sale_id: sale_id,
      receipt_type_id: receipt_type.id,
      company_id: company.id,
      email: email
    )
  end
end
