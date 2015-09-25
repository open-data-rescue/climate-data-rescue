class Pagetype < ActiveRecord::Base
  attr_accessible :author, :extern_ref, :title
  has_many :assets
  has_one :template
  belongs_to :ledger#, foreign_key: "ledger_id"

#TODO: Figure out what the hell this is for, and change it.
def front_page
    self.assets.where.order(:order).first
  end
  
  def next_unseen_for_user(user)
    seen = user.transcriptions.collect{|t| t.asset_id}
    self.assets.active.where(:id.nin=>seen).first
  end
  
  def remaining_active
    self.assets.where(:done=>false).count 
  end
  
  def active?
    self.remaining_active != 0 
  end 
  
end
