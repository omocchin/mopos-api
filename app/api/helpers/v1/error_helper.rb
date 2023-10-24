module Helpers
  module V1
    module ErrorHelper
      def unauthorized_error(message)
        error!({error: I18n.t('error_type.unauthorized_error'), message: message}, 401)
      end

      def not_found_error(message)
        error!({error: I18n.t('error_type.not_found_error'), message: message}, 404)
      end
    end
  end
end