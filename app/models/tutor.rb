class Tutor < ApplicationRecord
  has_secure_password
  has_many_and_belongs_to_many :groups
  has_many :books, through: :tutor_books
  has_many :tutor_books
  has_many :open_book_requests

  validates :full_name, :login, presense: true
  validates :password, length: { minimum: 6 }
end
