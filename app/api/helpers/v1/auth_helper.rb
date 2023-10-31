module Helpers
  module V1
    module AuthHelper
      def user_token_expiration
        (DateTime.current + 14.days).to_i
      end

      def company_token_expiration
        (DateTime.current + 1.years).to_i
      end
    
      def issued_at
        (Time.zone.now).to_i
      end

      def create_company_token(company)
        payload = {
          company_id: company.id,
          exp: company_token_expiration,
          iat: issued_at
        }
        token = JWT.encode(payload, ENV['SECRET_KEY'], 'HS256')
      end
    
      def create_user_token(user)
        payload = {
          user_id: user.id,
          exp: user_token_expiration,
          iat: issued_at
        }
        token = JWT.encode(payload, ENV['SECRET_KEY'], 'HS256')
      end

      def decode_token(company_token, user_token)
        decoded_company = JWT.decode(company_token, ENV['SECRET_KEY'], true)
        company = Company.find(decoded_company[0]['company_id'])
        company.company_histories.last.current_token?(company_token)
        decoded_user = nil
        user = nil
        if user_token
          decoded_user = JWT.decode(user_token, ENV['SECRET_KEY'], true)
          user = User.find(decoded_user[0]['user_id'])
          user.user_histories.last.current_token?(user_token)
        end
        return  user, company

      rescue Exceptions::NotCurrentToken => e
        forbidden_error(I18n.t('error_message.token_not_current'))
      rescue JWT::DecodeError => e
        forbidden_error(I18n.t('error_message.forbidden_error'))
      rescue ActiveRecord::RecordNotFound => e
        not_found_error(I18n.t('error_message.record_not_found', model: e.model))
      end

      def authenticate!
        tokens = request.headers['Authorization'].split(', ')
        company_token = tokens[0].split(' ').last
        user_token = tokens[1]&.split(' ')&.last
        @user, @company = decode_token(company_token, user_token)
      end
    end
  end
end