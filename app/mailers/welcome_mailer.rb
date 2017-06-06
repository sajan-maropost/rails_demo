class WelcomeMailer < ApplicationMailer

	def account_created_email(user_name, user_email)
		@user_name = user_name
		@user_email = user_email
    	mail(to: @user_email, subject: 'Welcome to Awesome Site')
	end

	def welcome_email(user_name, user_email)
		@name = user_name
		@user_email = user_email
		mail(to: @user_email, subject: 'Registration Successfull')
	end
end
