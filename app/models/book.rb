class Book < ApplicationRecord
  has_and_belongs_to_many :authors
  has_many :student_books, dependent: :destroy
  has_many :students, through: :student_books
  has_many :tutor_books, dependent: :destroy
  has_many :tutors, through: :tutor_books
  has_many :group_books, dependent: :destroy
  has_many :groups, through: :group_books
  has_many :open_book_requests
  has_one_attached :cover
  has_one_attached :content

  validates :book_name, :content, presence: true
end
