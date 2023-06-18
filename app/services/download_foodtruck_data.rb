require 'net/http'
require 'csv'

class DownloadFoodtruckData
  class << self

    def call
      FoodtruckData::Save.new.call(FoodtruckData::Download.call)
    end
  end
end