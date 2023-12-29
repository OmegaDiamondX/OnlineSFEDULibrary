class CreateInitialDb < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :full_name
      t.string :login
      t.timestamps
    end
    create_table :tutors do |t|
      t.string :full_name
      t.string :login
      t.timestamps
    end
    create_table :books do |t|
      t.references :author
      t.string :book_name
      t.integer :count
      t.boolean :restricted_access
      t.timestamps
    end
    create_table :authors do |t|
      t.string :full_name
      t.timestamps
    end
    create_table :groups do |t|
      t.string :group_name
      t.timestamps
    end
    create_table :open_book_requests do |t|
      t.references :book
      t.references :tutor
      t.timestamps
    end
    create_table :group_books do |t|
      t.references :book
      t.references :group
      t.integer :count
      t.timestamps
    end
    create_table :student_books do |t|
      t.references :book
      t.references :student
      t.references :group
      t.date :return_date
      t.timestamps
    end
    create_table :tutor_books do |t|
      t.references :book
      t.references :tutor
      t.references :group
      t.date :return_date
      t.timestamps
    end
    create_join_table :tutors, :groups
    create_join_table :students, :groups
  end
end
