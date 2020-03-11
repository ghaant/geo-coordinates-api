# frozen_string_literal: true

class GeoCoordinatesController < ApplicationController
  def locate
    client = Locationiq::Client.new

    if params[:token].nil?
      render(json: { message: 'Please provide your access token.', status: 406 }) && return
    elsif params[:search_value].nil?
      render(json: { message: 'Please input the search value: an address or a name of a place you are searching for.', status: 406 }) && return
    end

    response = client.coordinates(params[:token], params[:search_value])
    location = JSON.parse(response.body).first

    render json: { location: location['display_name'],
                   latitude: location['lat'],
                   longitude: location['lon'] }
  end
end
