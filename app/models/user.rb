class User < ApplicationRecord
  acts_as_token_authenticatable
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

  # devise overrides

  # to send mails in background using ActiveJob and sidekiq
  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
