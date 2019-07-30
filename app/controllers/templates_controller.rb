class TemplatesController < ApplicationController
	before_action :authenticate_user
	before_action :authenticate_admin_role
	def index
    @templates = Template.paginate(page: params[:page], per_page: PAGINATION_COUNT).order("name")
  end

	def new
		@template = Template.new
	end

	def create
		template = Template.new(template_params)   
    if template.save   
      flash[:notice] = 'Template added!'   
      redirect_to templates_path   
    else   
      flash[:warning] = template.errors.full_messages
      render :new   
    end 
	end

	private
	def template_params
		params.require(:template).permit(:name, :description)
	end
end
