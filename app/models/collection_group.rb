class CollectionGroup < ActiveRecord::Base
  attr_accessible :author, :extern_ref, :title, :asset_collection_id
  has_many :asset_collections
end
