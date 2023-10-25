module Helpers
  module V1
    module ErrorHelper
      def unauthorized_error(message)
        error!({error: I18n.t('error_type.unauthorized_error'), message: message}, 401)
      end

      def not_found_error(message)
        error!({error: I18n.t('error_type.not_found_error'), message: message}, 404)
      end

      def conflict_error(message)
        error!({error: I18n.t('error_type.conflict_error'), message: message}, 409)
      end
    end
  end
end