class AddStudentIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :student_id, :integer
  end
end
