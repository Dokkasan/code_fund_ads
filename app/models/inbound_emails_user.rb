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
class InboundEmailsUser < ApplicationRecord
  # extends ...................................................................
  # includes ..................................................................

  # relationships .............................................................
  belongs_to :inbound_email
  belongs_to :user

  # validations ...............................................................

  # callbacks .................................................................
  # scopes ....................................................................

  scope :unopened_emails, -> { where(opened_at: nil) }
  scope :opened_emails, -> { !unopened_emails }
  # scope :unopened_emails_for_user, ->(user) { where(user: user, ) }

  # additional config (i.e. accepts_nested_attribute_for etc...) ..............

  # class methods .............................................................
  # class << self
  # end

  # public instance methods ...................................................

  # protected instance methods ................................................
  protected

  # private instance methods ..................................................
  private
end
