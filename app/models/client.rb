class Client < ApplicationRecord
	validates :email, :uniqueness => true
  validates :email, :presence => true
  scope :active, -> { where(status: true) }

  def self.authenticate(username, password)
    password = User::encrypt(password)
    username.present? && password.present? ? self.where("(email = ?  OR mobile = ? )AND password = ?", username, username, password).first : nil
  end

  def self.create_client(params)
    client = self.new(:email => params[:email])
    client.full_name = params[:full_name]
    password = User.generate_random_password
    client.password = User.encrypt(password)
    client.otp = password
    client.department = params[:department]
    client.mobile = params[:mobile]
    client.role_id = params[:role_id]
    return client, password
  end
end
