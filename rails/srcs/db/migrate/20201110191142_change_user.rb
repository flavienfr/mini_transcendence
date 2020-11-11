class ChangeUser < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :is_admin, :boolean, :default => false
    change_column :users, :points, :integer, :default => 0
  end
end
