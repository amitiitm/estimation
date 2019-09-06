class DashboardsController < ApplicationController
	before_action :authenticate_user

  def index
    @users = User.all
    @clients = Client.all
    @estimations = Estimation.all
    @total_hours = Estimation.all.map {|e| e.estimation_templates.sum(&:final_hours) }.sum 
  end
end
