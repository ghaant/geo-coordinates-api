# frozen_string_literal: true

module LocationIQ
  class Connection
    API_BASE = 'https://eu1.locationiq.com/v1/search.php'

    def self.api
      Faraday.new(API_BASE) do |faraday|
        faraday.response :logger
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
