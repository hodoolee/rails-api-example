FactoryBot.define do
  factory :tag do
    name do
      loop do
        possible_word = Faker::Lorem.word
        break possible_word unless Tag.exists?(name: possible_word)
      end
    end
  end
end
