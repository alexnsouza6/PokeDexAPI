# README

# Running the application

First of all, its necessary to create the database, so type this inside a terminal at root of the project:
`rails db:create db:migrate`

And then `bundle install` to install all the gems.

After this, we should populate the db with all the pokemons:

**PS:** Especifically this part may take a few minutes depending on your network connection speed:

`rails pokedex_setup:pokemon` and after all the pokemons got fetched, type `rails pokedex_setup:evolutions` to query all the evolutions.

If it worked, you can type in your terminal: `rails console` and then `Pokemon.all` to see all the pokemons returned.

Finally, start the server with `rails s -p 8080` **(Must initialize server with port 8080)**

# Tests

The application tests used RSpec framework. To run them, type:
`bundle exec rspec spec`
