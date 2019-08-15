class Usecase < ApplicationRecord
	belongs_to :estimation
	validates :name, :presence => true

	COMPLEXITY = {'Low' => 10, 'Medium' => 20, 'High' => 30}
end
