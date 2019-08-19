class ModifyEstimationDetailsAndOffers < ActiveRecord::Migration[5.2]
  def change
    add_column :estimation_offers, :estimation_template_id, :integer
    add_column :estimation_details, :estimation_template_id, :integer
  end
end
