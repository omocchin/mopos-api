# == Schema Information
#
# Table name: company_histories
#
#  id          :bigint           not null, primary key
#  login_time  :datetime
#  logout_time :datetime
#  token       :string(500)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :bigint           not null
#
# Indexes
#
#  index_company_histories_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
require "test_helper"

class CompanyHistoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
