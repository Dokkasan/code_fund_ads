# See https://gorails.com/episodes/save-action-mailbox-html-emails-with-action-text
class IncomingMailbox < ApplicationMailbox
  include ActionView::Helpers::TextHelper

  before_processing :verify_participants

  def process
    email = Email.create! \
      action_mailbox_inbound_email_id: inbound_email.id,
      sender: mail.from.first,
      recipients: (mail.to.to_a + mail.cc.to_a).uniq.compact.sort,
      subject: mail.subject,
      snippet: snippet,
      body: body,
      direction: :inbound,
      delivered_at: (begin
                       DateTime.parse(mail.raw_source.match(%r{Date: (.*)\r\n})[1])
                     rescue
                       action_mailbox_inbound_email.created_at
                     end),
      attachments: attachments.map { |a| a[:blob] }

    return unless email.persisted?

    email.users = User.where(email: email.participant_addresses)
  end

  private

  # Only allow inbound emails with the following criteria:
  # 1. Sender must be either a publisher or advertiser
  # 2. Recipient must be a CodeFund administrator
  # 3. Recipient must have the 'record_inbound_emails' flag set to true
  def verify_participants
    return bounced! unless User.administrators.find_by(email: mail.to)&.record_inbound_emails?
    return bounced! if !User.advertisers.exists?(email: mail.from) && !User.publishers.exists?(email: mail.from)
  end

  def attachments
    @_attachments = mail.attachments.map { |attachment|
      blob = ActiveStorage::Blob.create_after_upload!(
        io: StringIO.new(attachment.body.to_s),
        filename: attachment.filename,
        content_type: attachment.content_type
      )
      {original: attachment, blob: blob}
    }
  end

  def body
    if mail.multipart? && mail.html_part
      document = Nokogiri::HTML(mail.html_part.body.decoded)

      attachments.map do |attachment_hash|
        attachment = attachment_hash[:original]
        blob = attachment_hash[:blob]

        if attachment.content_id.present?
          # Remove the beginning and end < >
          content_id = attachment.content_id[1...-1]
          element = document.at_css "img[src='cid:#{content_id}']"

          element.replace "<action-text-attachment sgid=\"#{blob.attachable_sgid}\" content-type=\"#{attachment.content_type}\" filename=\"#{attachment.filename}\"></action-text-attachment>"
        end
      end

      document.at_css("body").inner_html.encode("utf-8")
    elsif mail.multipart? && mail.text_part
      mail.text_part.body.decoded
    else
      mail.decoded
    end
  end

  def snippet
    stripped_body = ActionView::Base.full_sanitizer.sanitize(body)
    truncate(stripped_body, length: 300)
  end
end
