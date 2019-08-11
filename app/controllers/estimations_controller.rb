class EstimationsController < ApplicationController
	before_action :authenticate_user

	def index
    @estimations = Estimation.paginate(page: params[:page], per_page: PAGINATION_COUNT).order("created_at asc")
  end

  def new
  	@estimation = Estimation.new
  end

  def create
		estimation = Estimation.new(estimation_params)   
    if estimation.save   
      flash[:notice] = 'Estimation added!'   
      redirect_to estimations_path
    else   
      flash[:warning] = estimation.errors.full_messages
      redirect_to new_estimation_path
    end 
	end

	def estimation_details
		@template = Template.find(params[:tid])
		@estimation = Estimation.find(params[:eid])
	end

	def functional_scope
		@estimation = Estimation.find(functional_scope_params[:estimation_id])
		if request.method.eql? 'POST'
			if @estimation.functional_scope.present?
				@functional_scope = @estimation.functional_scope
				@functional_scope.assign_attributes(functional_scope_params)
			else
				@functional_scope = FunctionalScope.new(functional_scope_params)
			end
	    if @functional_scope.save   
	      flash[:notice] = 'Functional Scope added!'   
	      redirect_to estimations_path
	    else   
	      flash[:warning] = @functional_scope.errors.full_messages
	      redirect_to estimations_path
	    end
	  else
	  	if @estimation.functional_scope.present?
				@functional_scope = @estimation.functional_scope
			else
				@functional_scope = FunctionalScope.new
			end
		end
	end

	private
	def estimation_params
		params.require(:estimation).permit!
		#params.require(:estimation).permit(:name, :template_ids, :start_date, :end_date, :user_id, :client_id, :owner_email, :notification_emails, :followup_emails, :created_by)
	end

	def functional_scope_params
		params.require(:functional_scope).permit!
	end
end
