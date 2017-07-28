require 'elasticsearch/model'

class Todo < ApplicationRecord
  include Searchable
  
	has_many :items, dependent: :destroy
	belongs_to :user
end
