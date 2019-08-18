class AddHoursToSubCategories < ActiveRecord::Migration[5.2]
  def change
  	add_column :sub_categories, :low_hours, :integer, default: 0
  	add_column :sub_categories, :medium_hours, :integer, default: 0
  	add_column :sub_categories, :status, :boolean, default: true
  	add_column :estimations, :complexity, :integer
  end
end
