class CreateUserEmails < ActiveRecord::Migration[6.1]
  def change
    create_table :user_emails do |t|
      t.string :email
      t.references :user_detail
      t.timestamps
    end
  end
end
