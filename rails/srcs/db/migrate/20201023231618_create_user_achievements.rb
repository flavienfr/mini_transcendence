class CreateUserAchievements < ActiveRecord::Migration[6.0]
  def change
    create_table :user_achievements do |t|
      t.references :user, null: false, foreign_key: true
      t.references :achievement, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
