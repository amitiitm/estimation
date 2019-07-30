class UserNotifierMailer < ApplicationMailer
	def send_signup_email(user, password)
    @user = user
    @password = password
    mail( :to => user.email,
    :subject => "#{@user.full_name} you are added to #{APP_CONFIG[:product_name]}" )
  end

  def change_password(user, password)
    @user = user
    @password = password
    mail( :to => user.email,
    :subject => "#{@user.full_name} your password is changed successfully" )
  end

  def forgot_password(user, password)
    @user = user
    @password = password
    mail( :to => user.email,
    :subject => "#{@user.full_name} here is your new password" )
  end
end
