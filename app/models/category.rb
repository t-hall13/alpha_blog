class Category < ActiveRecord::Base
  validates :name, presence: true,  length: { maximum: 25, minimum: 4 }
  validates_uniqueness_of :name
end