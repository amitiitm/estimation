class CreateEstimationOffers < ActiveRecord::Migration[5.2]
  def change
    create_table :estimation_offers do |t|
    	t.integer :estimation_id
      t.integer :template_id
    	t.integer :category_id
    	t.string :category_name
    	t.integer :sub_category_id
    	t.string :sub_category_name
    	t.integer :hours
      t.timestamps
    end
  end
end
