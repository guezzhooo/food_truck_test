# README

This is John Lude's version of the Food Truck coding challenge

The intended functionality is as follows:
Created rake task `rake truckdata:download` to download the food truck data and install
into a MySQL database (filtering only those with Status = "APPROVED".)  The rake task
is idempotent.  Calling it after the data has changed will update the database rows.

Created an API endpoint to download the important food truck data (Applicant = company,
FacilityType, Latitude, Longitude, and LocationDescription, FoodItems) to use with the web UI.

Created a basic web ui to show all of the food trucks on a Google Map. Hovering over the marker
will show the name of the food truck.

You can see a sample of it here: http://foodtruck.johnlude.com/

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