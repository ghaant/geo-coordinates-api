# frozen_string_literal: true

class GeoCoordinatesController < ApplicationController
  def locate
    if params[:token].nil?
      response.status = 406
      render(json: { message: 'Please provide your access token.' }) && return
    elsif params[:search_value].nil?
      response.status = 406
      render(json: { message: 'Please input the search value: an address or a name of a place you are searching for.', status: response.status }) && return
    end

    client_response = Locationiq::Client.new.coordinates(params[:token], params[:search_value])

    if client_response.status == 401
      response.status = client_response.status
      render(json: { message: 'There is a problem with your access token.' }) && return
    elsif client_response.status == 404
      response.status = client_response.status
      render(json: { message: 'Nothing found. Please check the search value and try again.' }) && return
    elsif client_response.status == 200 && JSON.parse(client_response.body).length > 1
      response.status = 400
      render(json: { message: 'There are more than one result for this request. Please put it more specificly.' }) && return
    elsif client_response.status != 200
      response.status = 500
      render(json: { message: 'There is something wrong with LocationIQ service. Please try again later.' }) && return
    end

    location = JSON.parse(response.body).first

    render json: { location: location['display_name'],
                   latitude: location['lat'],
                   longitude: location['lon'] }
  end
end
