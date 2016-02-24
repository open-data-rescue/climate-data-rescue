class Pagetype < ActiveRecord::Base
  #attr_accessible :default_zoom, :description, :title, :ledger_id
  #TODO: remove :author and :extern_ref attributes from database and attr_accessible and update the form views for pagetype
  has_many :pages
  has_many :fieldgroups
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
