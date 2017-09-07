class ChangeUserAccessTypeInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :user_access, :integer, default: 0, index: true
  end
end
