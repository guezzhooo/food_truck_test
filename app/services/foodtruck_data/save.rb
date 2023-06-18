# frozen_string_literal: true

require 'csv'

module FoodtruckData
  class Save
    class ParseError < StandardError; end

    class FormatError < StandardError; end

    # Maps column names in CSV to Truck model
    FIELD_MAP = {
      'locationid': 'location_id',
      'Applicant': 'name',
      'FacilityType': 'facility_type',
      'LocationDescription': 'location_description',
      'Address': 'address',
      'Status': 'status',
      'FoodItems': 'food_items',
      'Latitude': 'latitude',
      'Longitude': 'longitude'
    }.with_indifferent_access

    def call(raw_data)
      data = parse(raw_data)
      validate(data)
      save(data)
    end

    private

    def parse(raw_data)
      CSV.parse(raw_data, headers: true)
    rescue RuntimeError => e
      raise ParseError, "Error parsing data: #{e.full_message}"
    end

    def validate(data)
      FIELD_MAP.each_key do |key|
        raise FormatError, "Invalid format: key '#{key}' not found" unless data.first.key?(key)
      end
      true
    end

    def save(data)
      data.each do |row|
        # No point showing trucks that aren't approved; can't show on a map missing latitude/longitude
        next unless row['Status'].downcase == 'approved' && !row['Latitude'].to_f.zero? && !row['Longitude'].to_f.zero?

        truck = Truck.find_or_create_by(location_id: row['locationid'].to_i)
        FIELD_MAP.each do |data_field, db_field|
          truck[db_field] = row[data_field.to_s] unless data_field.to_sym == :locationid
        end
        truck.save!
      end
    end
  end
end
