# frozen_string_literal: true

class CreateTrucks < ActiveRecord::Migration[7.0]
  def change
    create_table :trucks, id: false, primary_key: :location_id do |t|
      t.integer :location_id
      t.string :name
      t.string :facility_type
      t.string :location_description
      t.string :address
      t.string :status
      t.text :food_items
      t.decimal :latitude, precision: 20, scale: 10
      t.decimal :longitude, precision: 20, scale: 10
      t.timestamps
    end
  end
end
