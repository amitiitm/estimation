class CreateUsecases < ActiveRecord::Migration[5.2]
  def change
    create_table :usecases do |t|
			t.integer :estimation_id
			t.string :name
			t.integer :complexity
    	t.integer :ui_low_count, default: 0
    	t.integer :ui_medium_count, default: 0
    	t.integer :ui_high_count, default: 0
    	t.integer :service_low_count, default: 0
    	t.integer :service_medium_count, default: 0
    	t.integer :service_high_count, default: 0
      t.timestamps
    end
  end
end
