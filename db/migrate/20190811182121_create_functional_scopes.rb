class CreateFunctionalScopes < ActiveRecord::Migration[5.2]
  def change
    create_table :functional_scopes do |t|
    	t.integer :estimation_id
    	t.integer :usecase_low_count
    	t.integer :usecase_medium_count
    	t.integer :usecase_high_count
    	t.integer :ui_low_count
    	t.integer :ui_medium_count
    	t.integer :ui_high_count
    	t.integer :service_low_count
    	t.integer :service_medium_count
    	t.integer :service_high_count
    end
  end
end
