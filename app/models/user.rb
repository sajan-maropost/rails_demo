class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable


  # validations
  validates :name, presence: true

  # class methods
  def self.generate_password
    pass = ''
    pass += ('a'..'z').to_a.sample(2).join('')
    pass += (0..9).to_a.sample(7).join('')
    pass += ('A'..'Z').to_a.sample(1).join('')
  end

end
