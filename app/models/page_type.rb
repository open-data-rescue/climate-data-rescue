class PageType < ActiveRecord::Base
  has_many :pages
  has_many :field_groups, -> { order("page_types_field_groups.sort_order asc") }, through: :page_types_field_groups
  has_many :page_types_field_groups, dependent: :destroy

  has_many :fields, through: :field_groups

  has_many :transcriptions, through: :pages

  has_many :annotations, through: :transcriptions

  belongs_to :ledger #, foreign_key: "ledger_id"

#TODO: Figure out what the hell this is for, and change it.
  def front_page
    self.pages.where.order(:order).first
  end
  
  def next_unseen_for_user(user)
    seen = user.transcriptions.collect{|t| t.page_id}
    self.pages.active.where(:id.nin=>seen).first
  end
  
  def remaining_active
    self.pages.where(:done=>false).count 
  end
  
  def active?
    self.remaining_active != 0 
  end 
  
end
