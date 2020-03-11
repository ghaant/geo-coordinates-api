Rails.application.routes.draw do
  get '/locate' => 'geo_coordinates#locate'
end
