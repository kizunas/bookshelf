FactoryBot.define do
    factory :tag do
      id                          { |n| "#{n}"}
      name                        {"favorite"}
      user_id                     { |s| "#{s}"}
      created_at                  { Date.today }
      updated_at                  { Date.today }
    end
  end