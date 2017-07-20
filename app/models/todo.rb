require 'elasticsearch/model'

class Todo < ApplicationRecord
  
  has_many :items, dependent: :destroy
  belongs_to :user
end
Todo.import