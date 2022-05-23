FactoryBot.define do
    factory :book do
      id                          { |n| "#{n}"}
      title                       {"RSpec_try"}
      user_id                     { |s| "#{s}"}
      created_at                  { Date.today }
      updated_at                  { Date.today }
    end
  end