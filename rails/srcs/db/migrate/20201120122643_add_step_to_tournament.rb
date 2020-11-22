class AddStepToTournament < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :step, :integer
  end
end
