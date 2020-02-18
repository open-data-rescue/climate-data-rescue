
module BetterTogether
  module FriendlySlug
    extend ActiveSupport::Concern

    included do
      extend Mobility
      extend ::FriendlyId
      translates :slug

      validates :slug, presence: true

      # This method must be called or the class will have validation issues
      def self.slugged(attr)
        friendly_id attr, use: :mobility
      end
    end
  end
end
