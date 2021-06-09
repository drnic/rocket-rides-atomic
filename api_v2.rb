require "json"
require "sinatra"

require_relative "./config"

class API < Sinatra::Base
  set :server, %w[puma]
  set :show_exceptions, false

  post "/rides" do
    user = authenticate_user(request)
    params = validate_params(request)

    validate_request_or_error

    idempotently with: {user: user, params: params, request: request} do
      step :create_ride_tx
      step :stripe_charge_extn
      step :email_receipt_extn
    end
  end

  def create_ride_tx(user:, params:, request:)
  end

  def stripe_charge_extn(user:, params:, request:)
  end

  def email_receipt_extn(user:, params:, request:)
  end
end
