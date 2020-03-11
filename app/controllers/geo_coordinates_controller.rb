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

    render json: { latitude: JSON.parse(response.body).first['lat'],
                   longitude: JSON.parse(response.body).first['lon'] }
  end
end
