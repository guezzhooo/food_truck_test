require "test_helper"

module FoodtruckData
  class SaveTest < ActiveSupport::TestCase
    test 'saves data when data is parsable and valid' do
      Truck.all.each &:destroy
      data = <<END_JSON
locationid,Applicant,FacilityType,LocationDescription,Address,Status,FoodItems,Latitude,Longitude
12345,"Joe's Restaurant","Push Cart","Around the corner","12345 Main St, San Francisco, CA 12345","APPROVED","Good stuff",123.45,678.90
END_JSON
      FoodtruckData::Save.new.call(data)
      assert_equal 1, Truck.count
    end

    test 'does not save data when status is not approved' do
      Truck.all.each &:destroy
      data = <<END_JSON
locationid,Applicant,FacilityType,LocationDescription,Address,Status,FoodItems,Latitude,Longitude
12345,"Joe's Restaurant","Push Cart","Around the corner","12345 Main St, San Francisco, CA 12345","REJECTED","Good stuff",123.45,678.90
END_JSON
      FoodtruckData::Save.new.call(data)
      assert_equal 0, Truck.count
    end

    test 'raises no exceptions when data is parsable and valid' do
      data = <<END_JSON
locationid,Applicant,FacilityType,LocationDescription,Address,Status,FoodItems,Latitude,Longitude
12345,"Joe's Restaurant","Push Cart","Around the corner","12345 Main St, San Francisco, CA 12345","APPROVED","Good stuff",123.45,678.90
END_JSON
      assert_nothing_raised do
        FoodtruckData::Save.new.call(data)
      end
    end

    test 'when data not valid csv raises parse error' do
      data = '{"this":"is","not":"CSV"}'
      assert_raises(FoodtruckData::Save::ParseError) do
        FoodtruckData::Save.new.call(data)
      end
    end

    test 'when data missing locationid raises format error' do
      data = <<END_JSON
Applicant,FacilityType,LocationDescription,Address,Status,FoodItems,Latitude,Longitude
"Joe's Restaurant","Push Cart","Around the corner","12345 Main St, San Francisco, CA 12345","APPROVED","Good stuff",123.45,678.90
END_JSON
      assert_raises(FoodtruckData::Save::FormatError) do
        FoodtruckData::Save.new.call(data)
      end
    end

    test 'when data missing Applicant raises format error' do
      data = <<END_JSON
locationid,FacilityType,LocationDescription,Address,Status,FoodItems,Latitude,Longitude
12345,"Push Cart","Around the corner","12345 Main St, San Francisco, CA 12345","APPROVED","Good stuff",123.45,678.90
END_JSON
      assert_raises(FoodtruckData::Save::FormatError) do
        FoodtruckData::Save.new.call(data)
      end
    end

    test 'when data missing FacilityType raises format error' do
      data = <<END_JSON
locationid,Applicant,LocationDescription,Address,Status,FoodItems,Latitude,Longitude
12345,"Joe's Restaurant","Around the corner","12345 Main St, San Francisco, CA 12345","APPROVED","Good stuff",123.45,678.90
END_JSON
      assert_raises(FoodtruckData::Save::FormatError) do
        FoodtruckData::Save.new.call(data)
      end
    end

    test 'when data missing LocationDescription raises format error' do
      data = <<END_JSON
locationid,Applicant,FacilityType,Address,Status,FoodItems,Latitude,Longitude
12345,"Joe's Restaurant","Push Cart","12345 Main St, San Francisco, CA 12345","APPROVED","Good stuff",123.45,678.90
END_JSON
      assert_raises(FoodtruckData::Save::FormatError) do
        FoodtruckData::Save.new.call(data)
      end
    end

    test 'when data missing Address raises format error' do
      data = <<END_JSON
locationid,Applicant,FacilityType,LocationDescription,Status,FoodItems,Latitude,Longitude
12345,"Joe's Restaurant","Push Cart","Around the corner","APPROVED","Good stuff",123.45,678.90
END_JSON
      assert_raises(FoodtruckData::Save::FormatError) do
        FoodtruckData::Save.new.call(data)
      end
    end

    test 'when data missing Status raises format error' do
      data = <<END_JSON
locationid,Applicant,FacilityType,LocationDescription,Address,FoodItems,Latitude,Longitude
12345,"Joe's Restaurant","Push Cart","Around the corner","12345 Main St, San Francisco, CA 12345","Good stuff",123.45,678.90
END_JSON
      assert_raises(FoodtruckData::Save::FormatError) do
        FoodtruckData::Save.new.call(data)
      end
    end

    test 'when data missing FoodItems raises format error' do
      data = <<END_JSON
locationid,Applicant,FacilityType,LocationDescription,Address,Status,Latitude,Longitude
12345,"Joe's Restaurant","Push Cart","Around the corner","12345 Main St, San Francisco, CA 12345","APPROVED",123.45,678.90
END_JSON
      assert_raises(FoodtruckData::Save::FormatError) do
        FoodtruckData::Save.new.call(data)
      end
    end

    test 'when data missing Latitude raises format error' do
      data = <<END_JSON
locationid,Applicant,FacilityType,LocationDescription,Address,Status,FoodItems,Longitude
12345,"Joe's Restaurant","Push Cart","Around the corner","12345 Main St, San Francisco, CA 12345","APPROVED","Good stuff",678.90
END_JSON
      assert_raises(FoodtruckData::Save::FormatError) do
        FoodtruckData::Save.new.call(data)
      end
    end

    test 'when data missing Longitude raises format error' do
      data = <<END_JSON
locationid,Applicant,FacilityType,LocationDescription,Address,Status,FoodItems,Latitude
12345,"Joe's Restaurant","Push Cart","Around the corner","12345 Main St, San Francisco, CA 12345","APPROVED","Good stuff",123.45
END_JSON
      assert_raises(FoodtruckData::Save::FormatError) do
        FoodtruckData::Save.new.call(data)
      end
    end

  end
end
