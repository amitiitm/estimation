class LoginController < ApplicationController
  before_action :authenticate_user, only: [:update]
  layout "empty", only: [:index, :new, :sign_out]

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

  def update
    first_name = params[:user][:first_name]
    mobile = params[:user][:mobile]
    password = params[:user][:password]
    mailchimp_api_key = params[:user][:mailchimp_api_key]
    mailchimp_list_id = params[:user][:mailchimp_list_id]
    if first_name.present? && mobile.present? && password.present?
      name = first_name.split(' ')
      first_name = name[0]
      last_name = name[1..4].join(' ')
      encrypted_pwd = User.encrypt(password)
      current_user.update_attributes(first_name: first_name, last_name: last_name, mobile: mobile, password: encrypted_pwd, mailchimp_api_key: mailchimp_api_key, mailchimp_list_id: mailchimp_list_id)
      flash[:notice] = 'User details have been updated successfully.'
    else
      flash[:warning] = 'Insufficient parameters'
    end
    render 'edit'
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