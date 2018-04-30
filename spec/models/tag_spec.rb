require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "Associations" do
    it { should have_many(:posts).through(:taggings) }
  end

  describe "Validations" do
    subject { FactoryBot.create(:tag) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
