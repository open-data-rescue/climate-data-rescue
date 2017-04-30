class FieldOptionsController < ApplicationController
  respond_to :json

  def index
    begin
      @field_options = FieldOption.all
      if params[:field_id].present?
        @field = Field.find params[:field_id]
        @field_options = @field_options.select{|fo| !fo.fields.include?(@field) }
      end
    rescue => e
      flash[:danger] = e.message
    end
  end

  def for_field
    begin
      if params[:field_id].present?
        @field = Field.find params[:field_id]
        search = params[:search] ? params[:search] : nil

        if search
          @field_options = @field.field_options.where(["value like :q or name like :q or help like :q", :q => ("%" + search + "%")])
        else
          @field_options = @field.field_options
        end
      end
    rescue => e
      flash[:danger] = e.message
    end

    render "index"
  end
end