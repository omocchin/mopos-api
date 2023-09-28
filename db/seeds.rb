company = Company.create(company_unique_id: 'abcd1234', name: 'Kyle Mitsui', email: 'test@example.com', tel: '1111111111')

authority = UserAuthority.create(name: 'master')

user = User.create(company_id: company.id, user_authority_id: authority.id, login_id: 'test1234', password: 'aaaaaaaa', first_name: 'Kyle', last_name: 'Mitsui')