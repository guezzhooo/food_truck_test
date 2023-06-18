# frozen_string_literal: true

require 'test_helper'

module FoodtruckData
  class DownloadTest < ActiveSupport::TestCase
    test 'on successful download returns data' do
      stub_request(:get, 'https://data.sfgov.org/api/views/rqzj-sfat/rows.csv')
        .to_return(status: 200, body: '{"this":"is","a":"test"}')
      result = FoodtruckData::Download.call
      assert_equal '{"this":"is","a":"test"}', result
    end

    test 'raises exception when error downloading' do
      stub_request(:get, 'https://data.sfgov.org/api/views/rqzj-sfat/rows.csv')
        .to_return(status: 400, body: '{"this":"is","a":"test"}')
      assert_raises FoodtruckData::Download::DownloadError do
        FoodtruckData::Download.call
      end
    end
  end
end
