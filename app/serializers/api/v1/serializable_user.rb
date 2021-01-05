
module Api
  module V1
    # Serializes the User class
    class SerializableUser < ApplicationSerializer
      type 'users'

      has_one :user
    end
  end
end