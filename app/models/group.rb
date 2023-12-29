class Group < ApplicationRecord
  has_and_belongs_to_many :tutors
  has_and_belongs_to_many :students
  has_many :group_books, dependent: :destroy
  has_many :books, through: :group_books

  validates :group_name, presence: true
end
