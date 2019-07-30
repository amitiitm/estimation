class User < ApplicationRecord
	validates :email, :mobile, :uniqueness => true
  validates :email, :mobile, :presence => true
  validates :password, :presence => true
  validates :password, :confirmation => true, :presence => true, :on => :create

  ROLES = {'Admin' => 10, 'SME' => 20, 'Client' => 30}

  before_create :encrypt_password

  def self.authenticate(username, password)
    password = User::encrypt(password)
    username.present? && password.present? ? self.where("(email = ?  OR mobile = ? )AND password = ?", username, username, password).first : nil
  end

  def self.create_user(params)
    user = self.new(:email => params[:email], :mobile => params[:mobile])
    user.full_name = params[:full_name]
    user.password = params[:password]
    user.role_id = params[:role_id]
    user
  end

  def self.encrypt(password)
    Digest::SHA1.hexdigest("#{password}")
  end
  protected
  def encrypt_password
    self.password = User.encrypt(self.password)
  end
end
