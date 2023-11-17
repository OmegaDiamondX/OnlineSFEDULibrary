class Student_Book < ApplicationRecord
  belongs_to :book
  belongs_to :student
  belongs_to :group

  validates :book, :student, :take_date, presense: true
end
