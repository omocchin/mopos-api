module Helpers
  module V1
    module ErrorHelper
      def forbidden_error(message)
        error!({error: I18n.t('error_type.forbidden_error'), message: message}, 403)
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