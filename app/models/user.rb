# frozen_string_literal: true

# User
class User < ApplicationRecord
  # encrypt password
  has_secure_password

  # Model associations
  has_many :todos, foreign_key: :created_by, dependent: :destroy
  # Validations
  validates :name, :email, :password_digest, presence: true
end
