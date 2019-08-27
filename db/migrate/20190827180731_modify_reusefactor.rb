class ModifyReusefactor < ActiveRecord::Migration[5.2]
  def change
  	change_column :estimation_templates, :reuse_factor, :integer, :default => 0
  end
end
