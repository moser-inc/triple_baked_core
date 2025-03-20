FactoryBot.define do
  sequence :first_name do |n|
    "John#{n}"
  end
  
  sequence :last_name do |n|
    "Doe#{n}"
  end
  
  sequence :login do |n|
    "john#{n}doe#{n}"
  end
  
  sequence :email do |n|
    "john#{n}doe#{n}@email.com"
  end
  
  sequence :single_access_token do |n|
    "k3cF#{n}"
  end
    
  factory :spud_user do
    first_name { FactoryBot.generate(:first_name) }
    last_name { FactoryBot.generate(:last_name) }
    login { FactoryBot.generate(:login) }
    email { FactoryBot.generate(:email) }
    password { 'password' }
    password_confirmation { 'password' }
    single_access_token { FactoryBot.generate(:single_access_token) }
  end
end
