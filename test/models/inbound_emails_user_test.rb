# == Schema Information
#
# Table name: inbound_emails_users
#
#  id               :bigint           not null, primary key
#  opened_at        :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  inbound_email_id :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_inbound_emails_users_on_inbound_email_id  (inbound_email_id)
#  index_inbound_emails_users_on_user_id           (user_id)
#
require "test_helper"

class InboundEmailsUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
