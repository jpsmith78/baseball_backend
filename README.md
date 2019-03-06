# README

[link to person database](https://bballbackend.herokuapp.com/person)

[link to card databse](https://bballbackend.herokuapp.com/card)

## About this Application

    We made two full CRUD models with a one to many relationship. The first step was to create a new rails api with the database set to postgres by entering rails new baseball_backend --api -d postgresql into terminal. After cd-ing into the api, we started postgres and in a separate tab ran rails db:create to create our sub databases in postgres.  After this we ran rails s to start rails.

    At this point, we needed to agree upon what tables we wanted in our database.  We knew that we wanted a two model application, so we created a person table and a card table.  we passed these to each other through slack so there would be no local discrepancies.

    After that, we set our routes in config/routes.rb.  We made an app/controller ruby file and and app/models ruby file for each of our models.  We focused on getting full crud funtionality on both models before creating our one to many relationship.  Once we had that.  It was a simple matter writing out the commands we needed in sequel to git our relationship set.  

    Once everything was set, we deployed to heroku by adding the if else DB statement to the top of our classes in our models.  Then we pushed to heroku and used heroku pg:psql to create and alter our tables on heroku.

    After we deployed, there was little need for the local database, since we could reference the live site whether we worked locally or our live front end site.
* Ruby version

    2.6.1
* System dependencies

    Rails 5.2.2, postgres
* Configuration

    Cors.rb
* Database creation

    baseball_backend_development
    baseball_backend_test

    CREATE TABLE person (id serial, name varchar(100), age int, interest varchar(100));

    CREATE TABLE card (id serial, player varchar(100), team varchar(100), image varchar(200), position varchar(100), batting_avg decimal, owner_id int);
* Database initialization

    Deployed on Heroku
