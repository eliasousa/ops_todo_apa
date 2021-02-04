# frozen_string_literal: true

class Todo < ApplicationRecord
  validates :description, presence: true
end
