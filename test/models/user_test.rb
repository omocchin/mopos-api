# == Schema Information
#
# Table name: users
#
#  id                                  :bigint           not null, primary key
#  email                               :string(255)
#  first_name                          :string(255)      not null
#  last_name                           :string(255)      not null
#  password_digest                     :string(255)      not null
#  status(0: logged-out, 1: logged-in) :integer          default("logged_out"), not null
#  tel                                 :string(255)
#  created_at                          :datetime         not null
#  updated_at                          :datetime         not null
#  company_id                          :bigint           not null
#  login_id                            :string(255)      not null
#  user_authority_id                   :bigint           not null
#
# Indexes
#
#  index_users_on_company_id         (company_id)
#  index_users_on_user_authority_id  (user_authority_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (user_authority_id => user_authorities.id)
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
