class Author < ApplicationRecord
  has_many :books
  validates :full_name, presense: true
end
