class Book < ApplicationRecord
  belongs_to :author
  has_many :students, through: :student_books
  has_many :student_books
  has_many :tutors, through: :tutor_books
  has_many :tutor_books
  has_many :groups, through: :group_books
  has_many :group_books
  has_many :open_book_requests
  has_one_attached :cover
  has_one_attached :description
  has_one_attached :content

  validates :book_name, :content, presense: true
end
