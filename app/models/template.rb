class Template < ApplicationRecord
	validates :name, :uniqueness => true
  validates :name, :presence => true
	has_many :categories
end
