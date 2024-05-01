module Exceptions
  class NotCurrentToken < StandardError; end
  class TokenUnavailable < StandardError; end
  class UserNotFound < StandardError; end
  class CompanyNotFound < StandardError; end
  class DuplicateEntree < StandardError
    attr_reader :model

    def initialize(message, model)
      super(message)
      @model = model
    end
  end
  class EntreeNotfound < StandardError
    attr_reader :model

    def initialize(message, model)
      super(message)
      @model = model
    end
  end
  class ClientError < StandardError
    attr_reader :status

    def initialize(message, status)
      super(message)
      @status = status
    end
  end
  class ServerError < StandardError
    attr_reader :status

    def initialize(message, status)
      super(message)
      @status = status
    end
  end
end