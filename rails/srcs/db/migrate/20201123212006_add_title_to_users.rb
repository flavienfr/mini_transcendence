class AddTitleToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :title, null: true, foreign_key: true
    # remove_column :users, :user_title_id
  end
end
