class Tag < ApplicationRecord
has_many :taggings
has_many :albums, through: :taggings

def self.ransackable_attributes(auth_object = nil)
  [
    "name"
  ]
end
end
