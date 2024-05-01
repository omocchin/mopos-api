# == Schema Information
#
# Table name: sale_payments
#
#  id               :bigint           not null, primary key
#  change_amount    :decimal(50, 2)
#  paid_amount      :decimal(50, 2)   not null
#  tip_amount       :decimal(50, 2)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  payment_order_id :string(255)
#  payment_type_id  :bigint           not null
#  sale_id          :bigint           not null
#
# Indexes
#
#  index_sale_payments_on_payment_type_id  (payment_type_id)
#  index_sale_payments_on_sale_id          (sale_id)
#
# Foreign Keys
#
#  fk_rails_...  (payment_type_id => payment_types.id)
#  fk_rails_...  (sale_id => sales.id)
#
class SalePayment < ApplicationRecord
  belongs_to :payment_type
  belongs_to :sale

  def self.checkout_sale_payment(sale_id, payment_type_id, paid_amount)
    payment_type = PaymentType.find(payment_type_id)
    sale = Sale.find(sale_id)
    SalePayment.create(
      sale_id: sale.id,
      payment_type_id: payment_type.id,
      paid_amount: paid_amount,
      change_amount: paid_amount - sale.total
    )
  end

  def add_payment_order_id(order_id)
    self.update(payment_order_id: order_id)
  end
end
