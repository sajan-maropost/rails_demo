class UserQuery < ApplicationRecord

  # validations
  validates :name, :email, :description, presence: true

  validates :name, format: { with: /\A[a-zA-Z]+\z/,
    message: ":Only letters allowed." }, if: "name.present?"

  # RegEx below for Email might not be perfect
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
	message: "Enter a valid email"}, if: "email.present?"

  validates :mobile, numericality: { only_integer: true }, length: { minimum: 10 }, if: "mobile.present?"
end
