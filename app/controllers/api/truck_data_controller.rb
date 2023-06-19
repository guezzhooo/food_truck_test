# frozen_string_literal: true

module Api
  class TruckDataController < ApplicationController
    def map
      render json: Truck.all.select(:location_id, :name, :address, :latitude, :longitude, :facility_type, :location_description, :food_items)
    end
  end
end
