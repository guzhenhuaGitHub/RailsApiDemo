# frozen_string_literal: true

class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  # Service entry point - return valid user object
  def call
    {
      user: user
    }
  end

  private

  attr_reader :headers

  def user
    # check if user is in the database
    # memorize user object
    auth_token = decoded_auth_token
    @user ||= User.find(auth_token[:user_id]) if auth_token
    # handle user not found
  rescue ActiveRecord::RecordNotFound => e
    # raise custom error
    raise ExceptionHandler::InvalidToken, "#{Message.invalid_token} #{e.message}"
  end

  # decode authentication token
  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode http_auth_header
  end

  # check for token in `Authorization` header
  def http_auth_header
    authorization = headers[:Authorization]
    return authorization.split(' ').last if authorization.present?

    raise ExceptionHandler::MissingToken, Message.missing_token
  end
end
