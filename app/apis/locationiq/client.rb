# frozen_string_literal: true



module Locationiq
  class Client
    ENDPOINT = 'search.php'

    def coordinates(token, search_value)
      params = {
        key: token,
        format: 'json',
        q: search_value
      }
      get_request(params)
    end

    private

    def get_request(params)
      Locationiq::Connection.api.get(ENDPOINT, params)
    end
  end
end
