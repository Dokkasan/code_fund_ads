class AddOpenedAtToInboundEmailsUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :inbound_emails_users, :id, :primary_key
    add_column :inbound_emails_users, :opened_at, :datetime
    add_timestamps :inbound_emails_users, null: false, default: -> { "NOW()" }
  end
end
