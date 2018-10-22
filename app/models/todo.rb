# frozen_string_literal: true

# The todo of user
class Todo < ApplicationRecord
  # model association
  has_many :items, dependent: :destroy

  # validations
  validates :title, :created_by, presence: true
end
