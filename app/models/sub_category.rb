class SubCategory < ApplicationRecord
	validates :name, uniqueness: { scope: [:category_id, :status], message: 'should unique per category' }
  validates :name, :presence => true
	belongs_to :category

	scope :offered_sub_categories, -> { where(offer: true) }
	scope :active, -> { where(status: true) }

	before_save :remove_spaces

	OFFER = {'YES' => true, 'NO' => false}
	ONE_TIME_SETUP = 'one_time_setup'
	DEPENDS_ON_UI = 'depends_on_ui'
	DEPENDS_ON_SERVICE = 'depends_on_service'
	DEPENDS_ON_USECASE = 'depends_on_usecase'
	DEPENDS_ON_ITERATION = 'depends_on_iteration'

	CLASS_NAMES = {
										'Calculation Depends on UI' => DEPENDS_ON_UI, 
										'Calculation Depends on Service' => DEPENDS_ON_SERVICE, 
										'Calculation Depends on Usecase' => DEPENDS_ON_USECASE,
										'Calculation Depends on Iteration' => DEPENDS_ON_ITERATION,
										'Fixed One Time Setup' => ONE_TIME_SETUP
									}

	private
	def remove_spaces
		self.name = self.name.strip
	end


end
