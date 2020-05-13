class OutboundMailbox < ApplicationMailbox
  before_processing :verify_participants

  def process
    # email = OutboundEmail.create! \
    #   sender: mail.from.first,
    #   recipients: (mail.to.to_a + mail.cc.to_a).uniq.compact.sort,
    #   subject: mail.subject,
    #   snippet: snippet,
    #   body: body,
    #   delivered_at: (begin
    #                    DateTime.parse(mail.raw_source.match(%r{Date: (.*)\r\n})[1])
    #                  rescue
    #                    action_mailbox_inbound_email.created_at
    #                  end),
    #   attachments: attachments.map { |a| a[:blob] }

    # return unless email.persisted?

    # email.users = User.where(email: email.participant_addresses)
  end
  
  private

  # Only allow outbound emails with the following criteria:
  # 1. Sender must be a CodeFund administrator
  # 2. Recipient must be either a publisher or advertiser
  # 3. Sender must have the 'record_inbound_emails' flag set to true
  def verify_participants
    recipients = (mail.to.to_a + mail.cc.to_a)
    return bounced! unless User.administrators.find_by(email: mail.from)&.record_inbound_emails?
    return bounced! if !User.advertisers.exists?(email: recipients) && !User.publishers.exists?(email: recipients)
  end
end
