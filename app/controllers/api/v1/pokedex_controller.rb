# PokedexController handles request for the first 151 pokemons on pokedex API
class Api::V1::PokedexController < ApplicationController

  def request_pokemons
    if Pokemon.all.length == 151
      redirect_to pokemon_show_path
    else
      response = HTTParty.get("https://pokeapi.co/api/v2/pokemon?limit=151")
      pokemon_data = JSON.parse(response.to_s)
      pokemon_data["results"].each do |pokemon|
        Pokemon.create(name: pokemon["name"])
      end
    end
  end
end
