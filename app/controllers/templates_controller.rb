class TemplatesController < ApplicationController
	before_action :authenticate_user
	before_action :authenticate_admin_role

	def index
    @templates = Template.paginate(page: params[:page], per_page: PAGINATION_COUNT).order("name")
  end

	# for to get master data json and use in other DB
	def all_template_json
		templates = Template.all
		response = {}
		response['template'] = []
		response['categories'] = []
		response['subcategories'] = []
		templates.each do |template|
			categories = Category.where(template_id: template.id)
			response['template'] << template
			response['categories'] << categories
			categories.each do |category|
				response['subcategories'] << category.sub_categories
			end

		end
		render json: response
		#json_response(templates.joins(:categories))
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
