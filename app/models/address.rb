class Address < ApplicationRecord
  require 'net/http'
  require 'net/https'

  belongs_to :establishment
  #before_save :get_coordinates


  def get_coordinates
    api_key = 'AIzaSyArbhsTm43XpaAe6K03-v-2Ii8pp4pfguk'
    address = "#{self.street}, #{self.number}, #{self.uf}"
    str_uri = "https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=#{api_key}"

    uri = URI.parse(URI.escape(str_uri))

    response = Net::HTTP.get(uri)
    location = JSON.parse(response)
    p location

    latitude = location['results'][0]['geometry']['location']['lat']
    longitude = location['results'][0]['geometry']['location']['lng']

    self.lat = latitude
    self.long = longitude
  end
end
