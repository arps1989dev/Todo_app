module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    mapping do
      indexes :title, type: 'string'
    end

    def self.search(q)
      return nil if q.blank?

      Todo.__elasticsearch__.search q
      Todo.search q
    end

  end
end