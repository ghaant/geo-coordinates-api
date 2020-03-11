# frozen_string_literal: true

require './lib/locationiq/connection.rb'

module Locationiq
  class Client
    ENDPOINT = 'search.php'

    def coordinates(token, address)
      params = {
        key: token,
        format: 'json',
        q: address
      }
      get_request(params)
    end

    private

    def get_request(params)
      Locationiq::Connection.api.get(ENDPOINT, params)
    end
  end
end
