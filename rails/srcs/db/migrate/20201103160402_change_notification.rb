class ChangeNotification < ActiveRecord::Migration[6.0]
  def change
    remove_column :notifications, :to_user_id
    add_column :notifications, :user_id , :integer, :references => "users"
    add_column :notifications, :table_id, :integer
    remove_column :notifications, :type
    rename_column :notifications, :table_type, :string
  end
end
