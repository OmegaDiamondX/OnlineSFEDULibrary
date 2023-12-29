class StudentBook < ApplicationRecord
  belongs_to :book
  belongs_to :student
  validates :book, :student, presence: true

  before_create do
    @select_book = Book.find_by(id: book_id)
    @select_book.update(count: @select_book.count - 1) if @select_book.count > 0
  end

  before_destroy do
    @select_book = Book.find_by(id: book_id)
    @select_book.update(count: @select_book.count + 1) if @select_book.count >= 0
  end
end
