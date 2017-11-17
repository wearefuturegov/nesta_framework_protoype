class AddEmailSentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :email_sent, :boolean, null: false, default: false
  end
end
