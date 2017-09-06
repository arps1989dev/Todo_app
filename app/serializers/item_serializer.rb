class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :done, :created_at, :updated_at

  belongs_to :todo, key: "todo", serializer: TodoSerializer
end