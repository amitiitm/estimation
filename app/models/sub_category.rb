class SubCategory < ApplicationRecord
	validates :name, :uniqueness => true
  validates :name, :presence => true
	belongs_to :category
end
