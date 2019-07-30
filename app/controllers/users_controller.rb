class UsersController < ApplicationController
	def profile
		@user = current_user
	end

	def update
    @user = current_user
    if @user.update_attributes(user_params)
    	UserNotifierMailer.send_signup_email(@user).deliver_later 
      flash[:notice] = 'User Profile Updated'   
      redirect_to profile_users_path
    else   
      flash[:warning] = 'Failed to update profile!'   
      redirect_to profile_users_path
    end   
  end   
   

	private
  # Using a private method to encapsulate the permissible parameters is
  # just a good pattern since you'll be able to reuse the same permit
  # list between create and update. Also, you can specialize this method
  # with per-user checking of permissible attributes.
  def user_params
    params.require(:user).permit(:full_name,:age, :sex, :email,:mobile)
  end
end
