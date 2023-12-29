class ChangeDescriptionFormate < ActiveRecord::Migration[7.0]
  def change
    remove_column :books, :author_id, :integer
    add_column :books, :description, :string
  end
end
