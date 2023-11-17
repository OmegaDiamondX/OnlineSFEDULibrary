class Student < ApplicationRecord
  has_secure_password
  has_many_and_belongs_to_many :groups
  has_many :books, through: :student_books
  has_many :student_books

  validates :full_name, :login, presense: true
  validates :password, length: { minimum: 6 }
end
