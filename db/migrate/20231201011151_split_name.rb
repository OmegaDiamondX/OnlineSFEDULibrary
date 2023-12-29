class SplitName < ActiveRecord::Migration[7.0]
  def change
    remove_column :students, :full_name, :string
    remove_column :tutors, :full_name, :string
    remove_column :authors, :full_name, :string
    add_column :students, :first_name, :string
    add_column :students, :last_name, :string
    add_column :tutors, :first_name, :string
    add_column :tutors, :last_name, :string
    add_column :authors, :first_name, :string
    add_column :authors, :last_name, :string
    remove_reference :books, :authors
    create_join_table :authors, :books
  end
end
