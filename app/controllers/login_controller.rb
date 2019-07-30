class LoginController < ApplicationController
  before_action :authenticate_user, only: [:update]
  layout "empty", only: [:index, :new, :sign_out, :forgot_password]

  def index

  end

  def new
    @user = User.new
  end

  def sign_up
    @user = User.create_user(user_param)
    if @user.save
      init_session(@user)
      flash[:notice] = 'User details have been created successfully.'
      redirect_to dashboards_path
    else
      flash[:warning] = @user.errors.full_messages
      redirect_to root_url
    end
  end

  def sign_in
    if request.method.eql? 'POST'
      user_info = User.authenticate(params[:email], params[:password])
      if user_info.present?
        init_session(user_info)
        redirect_to dashboards_path and return
      else
        flash['warning'] = 'Incorrect Username or Password!'
        redirect_to root_url
      end
    else
      redirect_to dashboards_path if session[:id].present?
    end
  end

  def sign_out
    reset_session
    redirect_to root_url
  end

  def forgot_password
    if request.method.eql? 'POST'
      email = params[:email]
      user = User.where(email: email).first
      if user.present?
        new_password = User.generate_random_password
        user.update_attributes(password: User.encrypt(new_password))
        UserNotifierMailer.forgot_password(user, new_password).deliver_later
        flash[:notice] = 'Your password is successfully reset, Please check your registered Email'
      else
        flash[:warning] = 'Email is not registered with us'
      end
      redirect_to forgot_password_login_index_path
    end
  end

  private
  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def user_param
    params.require(:user).permit(:password, :confirm_password, :full_name,:age,:email,:mobile,:role_id)
  end
end