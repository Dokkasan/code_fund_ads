class CreateEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :emails do |t|
      t.text :body
      t.datetime :delivered_at, null: false
      t.string :recipients, array: true, default: [], null: false
      t.string :sender
      t.text :snippet
      t.text :subject
      t.bigint :action_mailbox_inbound_email_id, null: false
      t.integer :direction, default: Email.directions[:inbound]

      t.index :sender
      t.index :recipients, using: :gin

      t.timestamps
    end
  end
end
