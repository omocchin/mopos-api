module Helpers
  module V1
    module Helpers
      include AuthHelper
      include ErrorHelper
      include TimeHelper 
      include FaradayHelper
      include Apis::PaypalHelper
    end
  end
end