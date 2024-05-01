# == Schema Information
#
# Table name: payment_types
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PaymentType < ApplicationRecord
  has_many :sale_payments, dependent: :nullify

  def is_cash_payment?
    self.name == 'cash'
  end

  def is_card_payment?
    self.name == 'credit_card'
  end
end
