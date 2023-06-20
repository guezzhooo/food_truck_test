# Food Truck Coding Challenge
### John Lude

## Overview
This is my output from the coding challenge: https://github.com/peck/engineering-assessment
While the expectation was to spend 2-3 hours, I spent about a day and a half on it.  I created
a decent amount of functionality that showcases my ability with database migrations, separation
of concerns, Ruby and JavaScript coding, 3rd party (Google) implementation, and testing/linting.
I also had to brush up on Google Maps integration, setup a local environment as well as my
server for the demo link below.  I did ultimately cut a few corners on my server, as it's
running EasyApache4 with CPanel, so the setup's a little janky.

## Architecture
While this is a relatively simple project and I could've saved time by simply loading the CSV on
page load, I chose to store data to a database for 2 reasons.  First, this IS a coding challenge
so it gave me a chance to show off basic database migration skills.  Second, in a production
environment, we probably wouldn't want to hit the original data source a lot, nor would we want
our app's functionality to be dependent on a 3rd party.

The data download and save are split into 2 specific services (separation of concerns), and called
from a main service. I also created a simple rake task to make this run.  With the rake task, it
would be easy to set this up as a cron job to download data hourly, daily, weekly, etc.

I looked at a few mapping APIs but settled on Google for its solid functionality (which has
expanded quite a bit since the last time I implemented it.) I considered using "infowindows" to
show the data on the map, but decided to show it beside the map since it's a relatively large
amount of information.

## Functionality
* Created rake task `rake truckdata:download` to download the food truck data and install
into a MySQL database (filtering only those with Status = "APPROVED".)  The rake task
is idempotent.  Calling it after the data has changed will update the database rows.
* Created an API endpoint to download the important food truck data (name,
type, latitude, longitude, and location, and food) to use with the web UI.
* Created a basic web ui to show all of the food trucks on a Google Map.
  - Hovering over the marker will show the name of the food truck.
  - Clicking on a marker will update the Name, Type, Addres, Location, and Food on the right.

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
* `rake truckdata:download` to populate the database

## Testing
* Uses minitest: `rails test`
* Linting via `rubocop`