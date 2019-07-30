class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
 			t.string :full_name, :limit => 200
      t.string :mobile, :limit => 20
      t.string :email, :limit => 200
      t.string :password
      t.string :otp
      t.string :created_by
      t.string :updated_by
      t.string :department
      t.integer :role_id
      t.boolean :status, default: true
      t.timestamps null: false
    end
  end
end