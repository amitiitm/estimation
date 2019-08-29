class AddPmEffortToEstimationTemplate < ActiveRecord::Migration[5.2]
  def change
  	add_column :estimation_templates, :pm_factor, :integer, default: 0
  	add_column :estimation_templates, :pm_effort, :integer, default: 0
  	add_column :estimation_templates, :mr_factor, :integer, default: 0
  	add_column :estimation_templates, :mr_effort, :integer, default: 0
  end
end
