# frozen_string_literal: true

require 'net/http'
require 'csv'

class DownloadFoodtruckData
  class << self
    def call
      data = FoodtruckData::Download.call
      FoodtruckData::Save.new.call(data)
    end
  end
end
