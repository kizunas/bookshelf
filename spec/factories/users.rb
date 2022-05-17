FactoryBot.define do
    factory :user do
      name                    {"tester"}
      email                       { |n| "test#{n}@gmail.com" }
      password                    {"masterial"}
      password_confirmation       {"masterial"}
    end
  end