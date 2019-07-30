class Category < ApplicationRecord
	validates :name, :uniqueness => true
  validates :name, :presence => true
	has_many :sub_categories
	belongs_to :template
end
