# == Schema Information
#
# Table name: companies
#
#  id                :bigint           not null, primary key
#  email             :string(255)      not null
#  name              :string(255)      not null
#  tel               :string(255)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  company_unique_id :string(255)      not null
#
class Company < ApplicationRecord
end
