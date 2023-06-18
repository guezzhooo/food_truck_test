# frozen_string_literal: true

module Api
  class TruckDataController < ApplicationController
    def map
      render json: Truck.all.select(:location_id, :name, :latitude, :longitude, :facility_type)
    end
  end
end
