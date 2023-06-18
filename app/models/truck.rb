# frozen_string_literal: true

# == Schema Information
#
# Table name: trucks
#
#  location_id          :integer          primary key
#  name                 :string(255)
#  facility_type        :string(255)
#  location_description :string(255)
#  address              :string(255)
#  status               :string(255)
#  food_items           :text(65535)
#  latitude             :decimal(20, 10)
#  longitude            :decimal(20, 10)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Truck < ApplicationRecord
  self.primary_key = :location_id
end
