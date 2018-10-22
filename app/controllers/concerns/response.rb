# frozen_string_literal: true

# helper of Response
module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
