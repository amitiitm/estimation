class CreateEstimations < ActiveRecord::Migration[5.2]
  def change
    create_table :estimations do |t|
    	t.text :template_ids, array: true, default: []
    	t.integer :user_id
    	t.integer :client_id
    	t.string :name
    	t.boolean :status, default: true
    	t.string :owner_email
    	t.string :notification_emails
    	t.string :followup_emails
    	t.boolean :notification_flag
    	t.date :start_date
    	t.date :end_date
        t.integer :created_by
      t.timestamps
    end
  end
end
