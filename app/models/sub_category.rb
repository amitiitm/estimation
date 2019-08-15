class SubCategory < ApplicationRecord
	validates :name, uniqueness: { scope: :category_id, message: 'should unique per category' }
  validates :name, :presence => true
	belongs_to :category

	scope :offered_sub_categories, -> { where(offer: true) }

	OFFER = {'YES' => true, 'NO' => false}
	CLASS_NAMES = {
										'Calculation Depends on UI' => 'depends_on_ui', 
										'Calculation Depends on Service' => 'depends_on_service', 
										'Calculation Depends on Usecase' => 'depends_on_usecase'
									}
end
