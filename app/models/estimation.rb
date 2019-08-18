class Estimation < ApplicationRecord
	belongs_to :user
	belongs_to :client
	has_one :functional_scope
	has_many :usecases
	has_many :estimation_details
	has_many :estimation_offers

	before_save :flatten_template_ids
 
	validates :name, uniqueness: { scope: [:client_id], message: 'should unique per client' }
  validates :name, :presence => true
  validates :complexity, :presence => true

	APPLICABLE = {'Yes' => 1, 'No' => 0}

	def self.templates(ids)
		Template.where(id: ids)
	end

  private
 
  def flatten_template_ids
    self.template_ids = self.template_ids.flatten.uniq.sort.reject(&:blank?)
  end
end
