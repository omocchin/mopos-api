ActiveRecord::Base.transaction do
  company = Company.create(company_uuid: 'abcd1234', login_id: 'mopos', name: 'Mopos Co.', password: 'aaaaaaaa', email: 'test@example.com', tel: '1111111111')

  setting = company.create_setting(service_charge_amount: nil, tax: 10)

  authorities = ['master', 'company_master', 'company_manager', 'worker']
  authorities.each do |authority|
    UserAuthority.create(name: authority)
  end
  authority = UserAuthority.first

  user = User.create(company_id: company.id, user_authority_id: authority.id, login_id: 'test1234', password: 'aaaaaaaa', user_number: 11111111, first_name: 'Work', last_name: 'Hard')
  pay = Pay.create(user_id: user.id, hourly_rate: 10.00)

  item_catories = ['shirts', 'shorts', 'socks', 'shoes']
  item_catories.each do |item_category|
    ItemCategory.create(company_id: company.id, name: item_category)
  end
  categories = ItemCategory.all
  categories.each do |category|
    for i in 0..10 do
      rand_price = rand * (50.00 - 10.00) + 10.00
      item_code = Item.generate_item_code(company.company_uuid)
      Item.create(item_category_id: category.id, name: category.name + ' ' + i.to_s, price: rand_price.round(2), item_code: item_code)
    end
  end

  payments = ['cash', 'credit_card', 'other']
  payments.each do |payment|
    PaymentType.create(name: payment)
  end

  receipts = ['paper', 'email']
  receipts.each do |receipt|
    ReceiptType.create(name: receipt)
  end
end
