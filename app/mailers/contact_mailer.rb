class ContactMailer < ApplicationMailer

	def acknowledge_mail(email)
    @mail = email
    mail(to: @mail, subject: "Message Received!")
  end
end
