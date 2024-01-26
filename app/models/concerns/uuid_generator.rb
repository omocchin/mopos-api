module UuidGenerator
  extend ActiveSupport::Concern

  included do
    def self.generate_uuid
      return SecureRandom.uuid
    end
  end
end