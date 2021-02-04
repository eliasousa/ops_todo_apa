# frozen_string_literal: true

FactoryBot.define do
  factory :todo do
    sequence(:description) { |n| "Some description #{n}" }
    done { false }
  end
end
