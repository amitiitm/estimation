class SubCategoriesController < ApplicationController
	before_action :authenticate_user
	before_action :authenticate_admin_role
	def index
		@category_id = params[:id]
    @sub_categories = SubCategory.active.where(category_id: params[:id]).paginate(page: params[:page], per_page: PAGINATION_COUNT).order("name")
  end

	def new
		@category_id = params[:id]
		@sub_category = SubCategory.new
	end

	def create
		@sub_category = SubCategory.new(category_params)   
    if @sub_category.save   
      flash[:notice] = 'SubCategory added!'
      redirect_to "#{sub_categories_path}?id=#{@sub_category.category_id}"
    else   
      flash[:warning] = @sub_category.errors.full_messages
      render :new   
    end 
	end

	def edit
		@category_id = params[:category_id]
	  @sub_category = SubCategory.find(params[:id])
	end

  def update
    sub_category = SubCategory.find(params[:id])
    sub_category.update(category_params)
		flash[:notice] = 'SubCategory updated!'
    redirect_to "#{sub_categories_path}?id=#{sub_category.category_id}"
	end

	def destroy
		@category_id = params[:category_id]
		sub_category = SubCategory.find(params[:id])
		sub_category.update_attributes!(status: false)
		flash[:warning] = 'SubCategory deactivated!'
		redirect_to "#{sub_categories_path}?id=#{sub_category.category_id}"
	end

	private
	def category_params
		params.require(:sub_category).permit(:name, :description, :category_id, :hours, :low_hours, :medium_hours, :offer, :class_name, :status)
	end
end
