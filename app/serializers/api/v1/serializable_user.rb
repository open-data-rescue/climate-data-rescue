
module Api
  module V1
    # Serializes the User class
    class SerializableUser < ApplicationSerializer
      type 'user'

      attributes :id, :display_name

      attribute :user_url do
        @url_helpers.user_url(@object.id)
      end

    end
  end
end
