module Helpers
  module V1
    module TimeHelper
      CURRENT_TIME = Time.zone.now

      def day_time(time)
        time.strftime('%m/%d %H:%M')
      end
    end
  end
end