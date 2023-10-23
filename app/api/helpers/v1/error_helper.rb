module Helpers
  module V1
    module ErrorHelper
      def not_found_error
        error!('401 Unauthorized', 401)
      end
    end
  end
end