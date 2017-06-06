class UserQuery < ApplicationRecord

  # validations
  validates :name, :email, :mobile, :description, presence: true

  validates :name, format: { with: /\A[a-zA-Z]+\z/,
    message: "Only letters allowed in name" }

  # RegEx below for Email might not be perfect
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
	message: "Enter a valid email"}

  validates :mobile, numericality: { only_integer: true }, length: { minimum: 10 }
end
