class ClientMailer < ApplicationMailer
	def send_signup_email(client, password)
    @client = client
    @password = password
    mail( :to => client.email,
    :subject => "#{@client.full_name} Registered Succesfully to #{APP_CONFIG[:product_name]}" )
  end

  def generate_otp(client, password)
    @client = client
    @password = password
    mail( :to => client.email,
    :subject => "#{@client.full_name} your OTP for login is #{password}" )
  end
end
