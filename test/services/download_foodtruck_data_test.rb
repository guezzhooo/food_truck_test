# frozen_string_literal: true

require 'test_helper'

class DownloadFoodtruckDataTest < ActiveSupport::TestCase
  test 'retrieves data from online source and saves' do
    Truck.all.each(&:destroy)
    response_body = <<~END_JSON
      locationid,Applicant,FacilityType,LocationDescription,Address,Status,FoodItems,Latitude,Longitude
      12345,"Joe's Restaurant","Push Cart","Around the corner","12345 Main St, San Francisco, CA 12345","APPROVED","Good stuff",123.45,678.90
    END_JSON
    stub_request(:get, 'https://data.sfgov.org/api/views/rqzj-sfat/rows.csv')
      .to_return(status: 200, body: response_body)
    DownloadFoodtruckData.call
    assert_equal 1, Truck.count
  end

  test 'retrieves data from online source but does not save if not approved' do
    Truck.all.each(&:destroy)
    response_body = <<~END_JSON
      locationid,Applicant,FacilityType,LocationDescription,Address,Status,FoodItems,Latitude,Longitude
      12345,"Joe's Restaurant","Push Cart","Around the corner","12345 Main St, San Francisco, CA 12345","REJECTED","Good stuff",123.45,678.90
    END_JSON
    stub_request(:get, 'https://data.sfgov.org/api/views/rqzj-sfat/rows.csv')
      .to_return(status: 200, body: response_body)
    DownloadFoodtruckData.call
    assert_equal 0, Truck.count
  end
end
