class BeermappingApi

  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city) { fetch_places_in(city) }
  end

  def self.fetch_places_in(city)
    #url = "http://beermapping.com/webservice/loccity/#{key}/"
    url = 'http://stark-oasis-9187.herokuapp.com/api/'

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    # byebug
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do | place |
      Place.new(place)
    end
  end

  def self.fetch_place_in(id)
    #url = "http://beermapping.com/webservice/loccity/#{key}/"
    url = 'http://stark-oasis-9187.herokuapp.com/api/'

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(id)}"
    place = response.parsed_response["bmp_locations"]["location"]

    #return [] if place['id'].nil?
      Place.new(place)
  end

  def self.key
    "2561a75d783130b0464281bc5bb1665e"
  end

end