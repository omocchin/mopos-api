# == Schema Information
#
# Table name: receipt_types
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ReceiptType < ApplicationRecord
  has_many :sale_receipts, dependent: :nullify
end
