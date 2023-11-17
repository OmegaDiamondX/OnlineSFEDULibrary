class Group_Book < ApplicationRecord
  belongs_to :book
  belongs_to :group
end
