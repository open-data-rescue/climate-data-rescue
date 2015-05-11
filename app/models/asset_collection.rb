class AssetCollection < ActiveRecord::Base
  attr_accessible :author, :extern_ref, :title, :collectionID, :collection_group_id
  has_many :assets
  belongs_to :collection_group, foreign_key: "collection_group_id"

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
