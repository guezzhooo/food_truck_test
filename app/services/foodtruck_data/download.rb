# frozen_string_literal: true

require 'net/http'

module FoodtruckData
  class Download
    class DownloadError < RuntimeError; end
    URL = 'https://data.sfgov.org/api/views/rqzj-sfat/rows.csv'

    def self.call
      uri = URI(URL)
      response = Net::HTTP.get_response(uri)
      return response.body if response.code == '200'

      raise DownloadError, 'Unable to download foodtruck data'
    end
  end
end
