class AddTypeToTournaments < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :type, :string
  end
end
