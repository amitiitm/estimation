class AddOfferToSubCategories < ActiveRecord::Migration[5.2]
  def change
  	add_column :sub_categories, :offer, :boolean, default: false
  	add_column :sub_categories, :class_name, :string
  end
end
