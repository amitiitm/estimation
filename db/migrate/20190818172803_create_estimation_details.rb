class CreateEstimationDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :estimation_details do |t|
    	t.integer :estimation_id
        t.integer :template_id
    	t.integer :category_id
    	t.string :category_name
    	t.integer :sub_category_id
    	t.string :sub_category_name
    	t.integer :applicable
    	t.boolean :offer_flag
    	t.integer :per_component_low
    	t.integer :per_component_medium
    	t.integer :per_component_high
    	t.integer :component_low_count
    	t.integer :component_medium_count
    	t.integer :component_high_count
    	t.integer :estimated_total
    	t.integer :overridden_total
    	t.integer :created_by
      t.timestamps
    end
  end
end
