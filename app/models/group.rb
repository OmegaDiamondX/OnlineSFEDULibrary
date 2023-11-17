class Group < ApplicationRecord
  has_many_and_belongs_to_many :tutors
  has_many_and_belongs_to_many :students
  has_many :books, through: :group_books
  has_many :tutor_books
  has_many :student_books

  validates :group_name, presense: true
end
