class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable


  # callbacks
  after_create :send_welcome_mail

  # validations
  validates :name, presence: true

  # Instance methods
  def send_welcome_mail
    WelcomeMailer.welcome_email(self.name, self.email).deliver_now
  end
end
