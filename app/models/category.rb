class Category < ApplicationRecord
	validates :name, uniqueness: { scope: :template_id, message: 'should unique per template' }
  validates :name, :presence => true
	has_many :sub_categories
	belongs_to :template
end
