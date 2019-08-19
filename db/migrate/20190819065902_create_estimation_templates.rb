class CreateEstimationTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :estimation_templates do |t|
      t.integer :estimation_id
      t.integer :template_id
      t.text :category_ids, array: true, default: []
      t.integer :estimated_total
      t.integer :overridden_total
      t.boolean :offer_flag
      t.timestamps
    end
  end
end
