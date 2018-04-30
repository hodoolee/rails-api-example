class Tag < ApplicationRecord
  # associations
  has_many :taggings
  has_many :posts, through: :taggings

  # validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
