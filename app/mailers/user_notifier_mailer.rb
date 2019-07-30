class UserNotifierMailer < ApplicationMailer
	def send_signup_email(user)
    @user = user
    mail( :to => 'amit.pandey.iitm@gmail.com',
    :subject => 'Thanks for signing up for our amazing app' )
  end
end
