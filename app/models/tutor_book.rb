class Tutor_Book < ApplicationRecord
  belongs_to :book
  belongs_to :tutor
  belongs_to :group

  validates :book, :tutor, :date, presense: true
end
