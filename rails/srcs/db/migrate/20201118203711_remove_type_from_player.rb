class RemoveTypeFromPlayer < ActiveRecord::Migration[6.0]
  def change
    remove_column :players, :type, :string
  end
end
