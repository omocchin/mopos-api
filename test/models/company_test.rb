# == Schema Information
#
# Table name: companies
#
#  id                                  :bigint           not null, primary key
#  company_uuid                        :string(255)      not null
#  email                               :string(255)      not null
#  name                                :string(255)      not null
#  password_digest                     :string(255)      not null
#  status(0: logged-out, 1: logged-in) :integer          default("logged_out"), not null
#  tel                                 :string(255)      not null
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  login_id                            :string(255)      not null
#
# Indexes
#
#  index_companies_on_login_id  (login_id) UNIQUE
#
require "test_helper"

class CompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
