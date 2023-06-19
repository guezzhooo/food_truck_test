# README

This is John Lude's version of the Food Truck coding challenge

The intended functionality is as follows:
Create a rake task to download the food truck data and install into a database (filtering only those with Status = "APPROVED"

Create an API endpoint to download the important food truck data (Applicant = company, FacilityType, Latitude, Longitude, and LocationDescription, FoodItems to use with the web uis

Create a basic web ui to show all of the food trucks on a Google Map

Have a link on Google Map marker that points to a home page for the truck with LocationDescription and FoodItems

Notes for more documentation:

* Ruby version: 2.7.8
* Database: MySQL

* System dependencies

## Setup locally
* Clone the repo: `git clone git@github.com:guezzhooo/food_truck_test.git`
* `bundle install`
* Ensure you have a MySQL 8.0 server running.
  - host: localhost
  - database: foodtruck
  - username: foodtruck
  - password: wripLt0bruw9

* `rails db:migrate`