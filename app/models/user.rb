class User < ApplicationRecord
	validates :email, :mobile, :uniqueness => true
  validates :email, :mobile, :presence => true
  validates :password, :presence => true
  validates :password, :confirmation => true, :presence => true, :on => :create

  ROLES = {ADMIN => 10, SME => 20, CLIENT => 30}

  before_create :encrypt_password
	scope :active, -> { where(status: true) }

  def self.authenticate(username, password)
    password = User::encrypt(password)
    username.present? && password.present? ? self.where("(email = ?  OR mobile = ? )AND password = ?", username, username, password).first : nil
  end

  def self.create_user(params)
    user = self.new(:email => params[:email], :mobile => params[:mobile])
    user.full_name = params[:full_name]
    password = generate_random_password
    user.password = password
    user.role_id = params[:role_id]
    return user, password
  end

  def self.encrypt(password)
    Digest::SHA1.hexdigest("#{password}")
  end

	def self.generate_random_password
		'%08d' % rand(10 ** 8)
    # ('0'..'z').to_a.shuffle.first(8).join
  end

  protected
  def encrypt_password
    self.password = User.encrypt(self.password)
  end
end
