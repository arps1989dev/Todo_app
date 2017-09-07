class Item < ApplicationRecord
  belongs_to :todo
  enum status: { inactive: 0, active: 1 }
end
