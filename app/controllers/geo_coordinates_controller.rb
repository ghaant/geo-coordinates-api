# frozen_string_literal: true

require './lib/locationiq/connection.rb'

class GeoCoordinatesController < ApplicationController
  def locate
    client = Locationiq::Client.new

    if params[:token].nil?
      render(json: { message: 'Please provide your access token.', status: 406 }) && return
    elsif params[:search_value].nil?
      render(json: { message: 'Please input the search value: an address or a name of a place you are searching for.', status: 406 }) && return
    end

    response = client.coordinates(params[:token], params[:search_value])

    if response.status == 404
      render(json: { message: 'Nothing found. Please check the search value and try again.', status: 404 }) && return
    elsif response.status == 200 && JSON.parse(response.body).length > 1
      render(json: { message: 'There are more than one result for this request. Please put it more specificly.', status: 400 }) && return
    elsif response.status != 200
      render(json: { message: 'There is something wrong with LocationIQ service. Please try again later.', status: 500 }) && return
    end

    location = JSON.parse(response.body).first

    render json: { location: location['display_name'],
                   latitude: location['lat'],
                   longitude: location['lon'] }
  end
end
