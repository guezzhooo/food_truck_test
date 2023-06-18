require 'net/http'

module FoodtruckData
  class Download
    class DownloadError < RuntimeError; end
    URL = 'https://data.sfgov.org/api/views/rqzj-sfat/rows.csv'

    def self.call
      uri = URI(URL)
      response = Net::HTTP.get_response(uri)
      if response.code == '200'
        return response.body
      else
        raise DownloadError.new 'Unable to download foodtruck data'
      end
    end
  end
end