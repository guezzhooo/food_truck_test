# frozen_string_literal: true

namespace :truckdata do
  desc 'Download truck data'
  task download: :environment do
    DownloadFoodtruckData.call
  end
end
