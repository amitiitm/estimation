class Usecase < ApplicationRecord
	belongs_to :estimation
	validates :name, :presence => true
	validates :complexity, :presence => true

	before_save :check_values
	after_save :populate_functional_scope

	COMPLEXITY = {'Low' => 10, 'Medium' => 20, 'High' => 30}

	private
	def populate_functional_scope
		estimation_id = self.estimation.id
		fs = FunctionalScope.find_or_create_by(estimation_id: estimation_id)
		usecases = Usecase.where(estimation_id: estimation_id)
		fs.ui_low_count = usecases.sum(&:ui_low_count)
		fs.ui_medium_count = usecases.sum(&:ui_medium_count)
		fs.ui_high_count = usecases.sum(&:ui_high_count)
		fs.usecase_low_count = Usecase.where(complexity: COMPLEXITY['Low']).count
		fs.usecase_medium_count = Usecase.where(complexity: COMPLEXITY['Medium']).count
		fs.usecase_high_count = Usecase.where(complexity: COMPLEXITY['High']).count
		fs.service_low_count = usecases.sum(&:service_low_count)
		fs.service_medium_count = usecases.sum(&:service_medium_count)
		fs.service_high_count = usecases.sum(&:service_high_count)
		fs.save!
	end

	def check_values
		self.ui_low_count = self.ui_low_count.presence || 0
		self.ui_medium_count = self.ui_medium_count.presence || 0
		self.ui_high_count = self.ui_high_count.presence || 0
		self.service_low_count = self.service_low_count.presence || 0
		self.service_medium_count = self.service_medium_count.presence || 0
		self.service_high_count = self.service_high_count.presence || 0
	end
end
