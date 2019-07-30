class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
  helper_method :current_user, :is_admin?, :is_sme?, :is_client?

	def authenticate_user
		unless session[:id].present?
			redirect_to login_index_path
		end
	end

  def authenticate_admin_role
    unless is_admin?
      redirect_to dashboards_path
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

  def is_admin?
    session[:id].present? && session[:role].eql?(ADMIN)
  end

  def is_sme?
    session[:id].present? && session[:role].eql?(SME)
  end

  def is_client?
    session[:id].present? && session[:role].eql?(CLIENT)
  end
end
