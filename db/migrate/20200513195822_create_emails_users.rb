class CreateEmailsUsers < ActiveRecord::Migration[6.0]
  def change
    create_join_table :emails, :users do |t|
      t.index :email_id
      t.index :user_id
    end
  end
end
