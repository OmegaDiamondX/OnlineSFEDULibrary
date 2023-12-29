class Student < ApplicationRecord
  has_and_belongs_to_many :groups
  has_secure_password
  has_many :student_books, dependent: :destroy
  has_many :books, through: :student_books

  validates :first_name, :last_name, :login, presence: true
  validates :password, length: { minimum: 6 }

  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end
end
