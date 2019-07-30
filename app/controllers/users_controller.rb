class UsersController < ApplicationController
	before_action :authenticate_user
	before_action :authenticate_role, except: [:profile, :update, :update_password, :change_password]

	def index
    @users = User.paginate(page: params[:page], per_page: PAGINATION_COUNT).order("full_name")
  end

	def profile
		@user = current_user
	end

	def new
		@user = User.new
	end

  def create
    user, password = User.create_user(user_params)
    if user.save
    	UserNotifierMailer.send_signup_email(user, password).deliver_later
      flash[:notice] = 'User details have been created successfully.'
      redirect_to users_path
    else
      flash[:warning] = user.errors.full_messages
      redirect_to new_user_path
    end
  end

	def update
    @user = current_user
    if @user.update_attributes(user_update_params)
      flash[:notice] = 'User Profile Updated'
      redirect_to profile_users_path
    else   
      flash[:warning] = 'Failed to update profile!'
      redirect_to profile_users_path
    end   
  end   

  def change_password
  	user = User.authenticate(current_user.email, params[:password])
  	if user.present?
  		user.update_attributes(password: User.encrypt(params[:new_password]))
  		UserNotifierMailer.change_password(user, params[:new_password]).deliver_later
  		flash[:notice] = 'Password updated successfully'
  	else
  		flash[:warning] = 'Invalid Current Password'
  	end
  	redirect_to update_password_users_path
  end

  def activate
  	user = User.find(params[:id])
  	user.update_attributes(status: true)
  	flash[:notice] = 'User Profile Activated'
  	redirect_to users_path
  end

  def destroy
  	user = User.find(params[:id])
  	user.update_attributes(status: false)
  	flash[:warning] = 'User Profile Deactivated'
  	redirect_to users_path
  end

	private
  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def user_params
    params.require(:user).permit(:full_name, :age, :sex, :email, :mobile, :role_id)
  end

  def user_update_params
    params.require(:user).permit(:full_name, :age, :sex, :email, :mobile)
  end

  def authenticate_role
  	unless is_admin?
  		redirect_to dashboards_path
  	end
  end
end
