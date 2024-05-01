module Helpers
  module V1
    module FaradayHelper
      def api_request(url, path, method, auth, headers = {}, req_params = {}, body = {})
        conn = Faraday.new(
          url: url,
          params: req_params,
          headers: headers
        ) do |builder|
          case auth[:type]
          when 'basic' then
            builder.request :authorization, :basic, auth[:id], auth[:pass]
          when 'bearer' then
            builder.request :authorization, 'Bearer', auth[:token]
          end
          builder.response :logger
          builder.response :raise_error
        end

        response = conn.send(method, path) do |req|
          req.body = body
        end

      rescue Faraday::ClientError => e
        raise Exceptions::ClientError.new(JSON.parse(e.response_body)['message'], e.response_status)
      rescue Faraday::ServerError => e
        raise Exceptions::ServerError.new(JSON.parse(e.response_body)['message'], e.response_status)
      end
    end
  end
end