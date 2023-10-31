# == Schema Information
#
# Table name: companies
#
#  id                :bigint           not null, primary key
#  email             :string(255)      not null
#  name              :string(255)      not null
#  password_digest   :string(255)      not null
#  tel               :string(255)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  company_unique_id :string(255)      not null
#  login_id          :string(255)      not null
#
require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
