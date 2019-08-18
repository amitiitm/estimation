class EstimationDetail < ApplicationRecord
	belongs_to :estimation

	def self.create_details(params)
		estimation_details = params['estimation_details']
		estimation_offers = params['estimation_offers']
		ActiveRecord::Base.transaction do
			begin
				estimation_details['estimation_id'].each_with_index do |details, index|
					EstimationDetail.create(estimation_id: estimation_details['estimation_id'][index],
																	category_id: estimation_details['category_id'][index],
																	category_name: estimation_details['category_name'][index],
																	template_id: estimation_details['template_id'][index],
																	sub_category_id: estimation_details['sub_category_id'][index],
																	created_by: estimation_details['created_by'][index],
																	sub_category_name: estimation_details['sub_category_name'][index],
																	applicable: estimation_details['applicable'][index],
																	per_component_low: estimation_details['per_component_low'][index],
																	per_component_medium: estimation_details['per_component_medium'][index],
																	per_component_high: estimation_details['per_component_high'][index],
																	component_low_count: estimation_details['component_low_count'][index],
																	component_medium_count: estimation_details['component_medium_count'][index],
																	component_high_count: estimation_details['component_high_count'][index],
																	estimated_total: estimation_details['estimated_total'][index],
																	overridden_total: estimation_details['overridden_total'][index],
																	offer_flag: estimation_details['offer_flag']
																)
				end

				estimation_offers['estimation_id'].each_with_index do |offers, index|
					EstimationOffer.create(	estimation_id: estimation_offers['estimation_id'][index],
																	category_id: estimation_offers['category_id'][index],
																	category_name: estimation_offers['category_name'][index],
																	sub_category_id: estimation_offers['sub_category_id'][index],
																	sub_category_name: estimation_offers['sub_category_name'][index],
																	hours: (estimation_offers['hours'][index]&.strip&.split(' ')[1]&.to_i.presence || 0),
																	template_id: estimation_offers['template_id'][index]
																)
				end
				return true
			rescue ActiveRecord::StatementInvalid
				return false
			end
		end
	end
end
