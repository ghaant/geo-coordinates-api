# frozen_string_literal: true

module Locationiq
  class Connection
    API_BASE = 'https://eu1.locationiq.com/v1'

    def self.api
      Faraday.new(API_BASE) do |faraday|
        faraday.response :logger
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
