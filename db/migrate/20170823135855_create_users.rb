class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :firt_name
      t.string :last_name
      t.string :user_name
      t.string :email
      t.string :password
      t.string :profile_pic
      t.string :bio

      t.timestamps
    end
  end
end
