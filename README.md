# README

This is John Lude's version of the Food Truck coding challenge

The intended functionality is as follows:
Created rake task `rake truckdata:download` to download the food truck data and install
into a MySQL database (filtering only those with Status = "APPROVED".)  The rake task
is idempotent.  Calling it after the data has changed will update the database rows.

Created an API endpoint to download the important food truck data (Applicant = company,
FacilityType, Latitude, Longitude, and LocationDescription, FoodItems) to use with the web UI.

Created a basic web ui to show all of the food trucks on a Google Map.

The intent was to create a future version in which clicking the map marker would show either
a pop up or new page with the location description and food items. Could also use facility type
to show different icons on map.

## System Dependencies
* Ruby version: 2.7.8
* Database: MySQL

## Setup locally
* Clone the repo: `git clone git@github.com:guezzhooo/food_truck_test.git`
* `bundle install`
* Ensure you have a MySQL 8.0 server running.
  - host: localhost
  - database: foodtruck
  - username: foodtruck
  - password: wripLt0bruw9
* `rails db:migrate`

## Testing
* Uses minitest
* `rails test`