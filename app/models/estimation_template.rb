class EstimationTemplate < ApplicationRecord
  belongs_to :estimation
  has_many :estimation_details
  has_many :estimation_offers
  
  before_save :flatten_category_ids

	def self.estimation_template_by_template_id(template_id, estimation_id)
		self.where(template_id: template_id, estimation_id: estimation_id).first
	end

  private
 
  def flatten_category_ids
    self.category_ids = self.category_ids.flatten.uniq.sort.reject(&:blank?)
  end
end
