require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Associations" do
    it { should have_many(:tags).through(:taggings) }
  end

  describe "Validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end
end
