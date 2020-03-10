# frozen_string_literal: true

require './lib/locationiq/connection.rb'

module Locationiq
  class Client
    def coordinates(params)
# params = {key: 'ce25d225926be5', format: 'json', q: 'teterower ring 6'}
      get_request('search.php', params)
    end

    private

    def get_request(endpoint, params)
      Locationiq::Connection.api.get(endpoint, params)
    end
  end
end
