class ApplicationController < ActionController::Base
  include Response
	protect_from_forgery with: :exception
  helper_method :current_user, :is_admin?, :is_sme?, :is_client?

	def authenticate_user
		unless session[:id].present?
			redirect_to login_index_path
		end
	end

  def authenticate_admin_role
    unless is_admin?
      if is_sme?
        redirect_to dashboards_path
      elsif is_client?
        flash[:warning] = 'UnAuthorized Access!'
        redirect_to estimations_path
      end 
    end
  end

  def authenticate_sme_and_admin_role
    unless is_admin? || is_sme?
      flash[:warning] = 'UnAuthorized Access!'
      redirect_to estimations_path
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
