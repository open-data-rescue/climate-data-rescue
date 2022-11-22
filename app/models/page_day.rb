class PageDay < ApplicationRecord
  belongs_to :page, autosave: true

  before_save :update_parents

  def update_parents
    page.save!
  end
end
