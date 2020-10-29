class ChangeContexToContext < ActiveRecord::Migration[6.0]
  def change
    rename_column :games, :contex, :context
  end
end
