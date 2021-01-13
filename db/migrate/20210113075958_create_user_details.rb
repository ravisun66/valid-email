class CreateUserDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :user_details do |t|
      t.string :first_name
      t.string :last_name
      t.string :url
      
      t.timestamps
    end
  end
end
