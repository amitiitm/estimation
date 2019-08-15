class CategoriesController < ApplicationController
	before_action :authenticate_user
	before_action :authenticate_admin_role
	def index
		@template_id = params[:id]
    @categories = Category.where(template_id: params[:id]).paginate(page: params[:page], per_page: PAGINATION_COUNT).order("name")
  end

	def new
		@template_id = params[:id]
		@category = Category.new
	end

	def create
		category = Category.new(category_params)   
    if category.save   
      flash[:notice] = 'Category added!'   
      redirect_to "#{categories_path}?id=#{category.template_id}"   
    else   
      flash[:warning] = category.errors.full_messages
      redirect_to "#{categories_path}?id=#{category_params[:template_id]}"
    end 
	end

	private
	def category_params
		params.require(:category).permit(:name, :description, :template_id)
	end
end
