class ChangeGroupBookProperties < ActiveRecord::Migration[7.0]
  def change
    remove_column :group_books, :count, :integer
    add_column :group_books, :return_date, :date
  end
end
