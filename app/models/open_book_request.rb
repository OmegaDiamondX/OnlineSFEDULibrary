class OpenBookRequest < ApplicationRecord
  belongs_to :book
  belongs_to :tutor

  validates :tutor, :book, :request_date, presence: true
end