# Base JSONAPI serializer that sets common attrbutes
class ApplicationSerializer < JSONAPI::Serializable::Resource
  attribute :created_at_datestring do
    I18n.l(@object.created_at, format: :long)
  end

  attribute :updated_at_datestring do
    I18n.l(@object.updated_at, format: :long)
  end
end
