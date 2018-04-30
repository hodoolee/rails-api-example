class Post < ApplicationRecord
  # associations
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  # validations
  validates_presence_of :title, :body

  def tag_list=(names)
    self.tags = names.map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

end
