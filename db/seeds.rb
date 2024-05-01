company = Company.create(company_uuid: 'abcd1234', login_id: 'mipos', name: 'Mipos Co.', password: 'aaaaaaaa', email: 'test@example.com', tel: '1111111111')

setting = company.create_setting(service_charge_amount: nil, tax: 10)

authority = UserAuthority.create(name: 'master')
UserAuthority.create(name: 'company_master')
UserAuthority.create(name: 'comapny_manager')
UserAuthority.create(name: 'worker')

user = User.create(company_id: company.id, user_authority_id: authority.id, login_id: 'test1234', password: 'aaaaaaaa', user_number: 11111111, first_name: 'Tarou', last_name: 'Test')
pay = Pay.create(user_id: user.id, hourly_rate: 10.00)

item_category = ItemCategory.create(company_id: 1, name: 'testo')

for i in 0..10 do
  Item.create(item_category_id: item_category.id, name: 'testo ' + i.to_s, price: 2*i)
end

PaymentType.create(name: 'cash')
PaymentType.create(name: 'credit_card')
PaymentType.create(name: 'other')
ReceiptType.create(name: 'paper')
ReceiptType.create(name: 'email')
