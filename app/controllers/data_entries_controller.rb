class DataEntriesController < ApplicationController

	def create

	end

	protected
	def data_entry_params
		params.require(:data_entry).permit(:value, :type, :user_id, :field_id, :page_id, :annotation_id)
	end


end