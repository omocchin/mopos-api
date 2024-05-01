module Helpers
  module V1
    module Apis
      module PaypalHelper
        include FaradayHelper
        def paypal_auth
          response = api_request(
            Settings.requests.api.paypal.url.base_url,
            Settings.requests.api.paypal.url.paths.auth,
            'post',
            {
              type: 'basic',
              id: ENV['PAYPAL_CLIENT_ID'],
              pass: ENV['PAYPAL_CLIENT_SECRET']
            },
            {
              'Content-Type' => Settings.requests.headers.www_form
            },
            {},
            URI.encode_www_form({grant_type: 'client_credentials'})
          )
          response_body = JSON.parse(response.body)
        end

        def create_order(total_amount, card_info, company_uuid_last)
          auth_response = paypal_auth
          response = api_request(
            Settings.requests.api.paypal.url.base_url,
            Settings.requests.api.paypal.url.paths.create_order,
            'post',
            {
              type: 'bearer',
              token: auth_response['access_token']
            },
            {
              'PayPal-Request-Id': "#{company_uuid_last}-#{SecureRandom.uuid}",
              'Content-Type': Settings.requests.headers.application_json
            },
            {},
            {
              purchase_units: [{amount: {currency_code: 'USD', value: '100.00'}}],
              intent: 'CAPTURE',
              payment_source: {
                card: {
                  name: card_info[:name],
                  number: card_info[:number],
                  security_code: card_info[:security_code],
                  expiry: card_info[:expiry]
                }
              }
            }.to_json
          )
          JSON.parse(response.body)

        rescue Exceptions::ClientError => e
          raise Exceptions::ClientError.new('Payment order request ended with client error.', e.status)
        rescue Exceptions::ServerError => e
          raise Exceptions::ServerError.new('Payment order request ended with server error.', e.status)
        end
      end
    end
  end
end
