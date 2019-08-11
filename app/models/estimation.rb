class Estimation < ApplicationRecord
	belongs_to :user
	belongs_to :client
	has_one :functional_scope

	before_save :flatten_template_ids
 
	def self.templates(ids)
		Template.where(id: ids)
	end


  private
 
  def flatten_template_ids
    self.template_ids = self.template_ids.flatten.uniq.sort.reject(&:blank?)
  end
end
