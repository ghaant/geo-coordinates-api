# frozen_string_literal: true

require './lib/locationiq/connection.rb'

class GeoCoordinatesController < ApplicationController
  def locate
    client = Locationiq::Client.new

    if params[:token].nil?
      response.status = 406
      render(json: { message: 'Please provide your access token.', status: response.status }) && return
    elsif params[:search_value].nil?
      response.status = 406
      render(json: { message: 'Please input the search value: an address or a name of a place you are searching for.', status: response.status }) && return
    end

    response = client.coordinates(params[:token], params[:search_value])

    if response.status == 401
      render(json: { message: 'There is a problem with your access token.', status: response.status }) && return
    elsif response.status == 404
      render(json: { message: 'Nothing found. Please check the search value and try again.', status: response.status }) && return
    elsif response.status == 200 && JSON.parse(response.body).length > 1
      response.status = 400
      render(json: { message: 'There are more than one result for this request. Please put it more specificly.', status: response.status }) && return
    elsif response.status != 200
      response.status = 500
      render(json: { message: 'There is something wrong with LocationIQ service. Please try again later.', status: response.status }) && return
    end

    location = JSON.parse(response.body).first

    render json: { location: location['display_name'],
                   latitude: location['lat'],
                   longitude: location['lon'] }
  end
end
