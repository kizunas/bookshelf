FactoryBot.define do
    factory :user do
      id                          { |n| "#{n}"}
      email                       { |n| "test#{n}@gmail.com" }
      password                    {"masterial"}
      password_confirmation       {"masterial"}
      created_at                  { Date.today }
      updated_at                  { Date.today }
    end
  end