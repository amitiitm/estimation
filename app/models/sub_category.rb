class SubCategory < ApplicationRecord
	validates :name, uniqueness: { scope: :category_id, message: 'should unique per category' }
  validates :name, :presence => true
	belongs_to :category
end
