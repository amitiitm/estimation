class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
  helper_method :current_user
	 
	def authenticate_user
		unless session[:id].present?
			redirect_to login_index_path
		end
	end

  def init_session(obj)
    session[:id] = obj.id
    session[:user_id] = obj.id
    session[:user_name] = obj.full_name
    session[:email] = obj.email
    session[:role] = User::ROLES.key(obj.role_id)
  end

  def current_user
    session[:id].present? ?  User.find(session[:id]) : []
  end
end
