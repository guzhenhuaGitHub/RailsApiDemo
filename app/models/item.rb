# frozen_string_literal: true

# the Item of Todo
class Item < ApplicationRecord
  # model association
  belongs_to :todo

  # validation
  validates :name, presence: true
end
