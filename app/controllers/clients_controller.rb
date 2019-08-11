class ClientsController < ApplicationController
	layout "empty", only: [:register, :login]
	before_action :authenticate_user, only: [:index]
	before_action :authenticate_admin_role, only: [:index]

	def index
    @clients = Client.paginate(page: params[:page], per_page: PAGINATION_COUNT).order("full_name")
  end

	def register
		if request.method.eql? 'POST'
			client, otp = Client.create_client(client_params)
			if client.save
				ClientMailer.send_signup_email(client, otp).deliver_later
	      flash[:notice] = 'Enter OTP and login here.'
	      redirect_to login_clients_path
			else
				flash[:warning] = client.errors.full_messages
      	redirect_to register_clients_path
			end
		end
	end

	def login
		if request.method.eql? 'POST'
			client = Client.authenticate(params[:email], params[:password])
      if client.present?
        init_session(client)
        redirect_to dashboards_path and return
      else
        flash[:warning] = 'Incorrect Username or Password!'
        redirect_to login_clients_path
      end
		end
	end

	def generate_otp
		if request.method.eql? 'POST'
			client = Client.where(email: params[:email]).first
			if client.present?
				new_password = User.generate_random_password
        client.update_attributes(password: User.encrypt(new_password), otp: new_password)
        ClientMailer.generate_otp(client, new_password).deliver_later
        flash[:notice] = 'We have sent your OTP on your Email.'
			else
				flash[:warning] = 'Client email is not registered with us.'
			end
			render json: client
		end
	end

	private
	def client_params
    params.require(:client).permit(:full_name, :email, :mobile, :department, :role_id)
  end
end
