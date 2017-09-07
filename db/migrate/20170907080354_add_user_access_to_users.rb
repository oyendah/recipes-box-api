class AddUserAccessToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_access, :string
  end
end
