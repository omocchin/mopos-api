module Helpers
  module V1
    module AuthHelper
      def token_expiration
        (DateTime.current + 14.days).to_i
      end
    
      def issued_at
        (Time.zone.now).to_i
      end
    
      def create_token(user)
        payload = {
          user_id: user.id,
          company_id: user.company_id,
          exp: token_expiration,
          iat: issued_at
        }
        token = JWT.encode(payload, ENV['SECRET_KEY'], 'HS256')
      end

      def decode_token(token)
        decoded = JWT.decode(token, ENV['SECRET_KEY'], true)
        user = User.find(decoded[0]['user_id'])
        company = Company.find(decoded[0]['company_id'])
        user.user_histories.last.current_token?(token)
        return  user, company

      rescue Exceptions::NotCurrentToken => e
        forbidden_error(I18n.t('error_message.token_not_current'))
      rescue JWT::DecodeError => e
        forbidden_error(I18n.t('error_message.forbidden_error'))
      rescue ActiveRecord::RecordNotFound => e
        not_found_error(I18n.t('error_message.record_not_found', model: e.model))
      end

      def authenticate!
        token = request.headers['Authorization'].split(' ').last
        @user, @company = decode_token(token)
      end
    end
  end
end