class AddTypeToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :type, :string
  end
end
