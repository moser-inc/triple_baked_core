FactoryBot.define do
  sequence :name do |n|
    "SomeRole#{n}"
  end

  factory :spud_role do
    name { FactoryBot.generate(:name) }
  end
end