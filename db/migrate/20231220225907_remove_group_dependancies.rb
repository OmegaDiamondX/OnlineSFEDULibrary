class RemoveGroupDependancies < ActiveRecord::Migration[7.0]
  def change
    remove_column :tutor_books, :group_id, :integer
    remove_column :student_books, :group_id, :integer
  end
end
