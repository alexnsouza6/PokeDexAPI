
# This task handles database population w/ requests to PokeAPI



namespace :pokedex_setup do

  desc "Pokedex pokemons setup for system"
  task :pokemon => :environment do

    # Sets pokemon limit
    POKEMON_NUMBER = 151
    puts 'Gathering Pokemons...'
    puts 'It could take a while...'
    (1..POKEMON_NUMBER).each do |pokemon|
      # Makes http request to pokemon API
      response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{pokemon}")
      pokemon_data = JSON.parse(response.to_s)
      
      # Recognizes types from each pokemon and save in database
      types = []
      pokemon_data["types"].each do |pokemon_type|
        types << Type.find_or_create_by(description: pokemon_type["type"]["name"])
      end

      # Creates a pokemon in db based on JSON response and accumulated types
      Pokemon.find_or_create_by(name: pokemon_data["name"],
                                image_url: pokemon_data["sprites"]["front_default"],
                                types: types                          
                                )
      puts "#{pokemon} loaded..."  
    end
    puts 'All done!'
  end

  desc "Pokedex evolutions setup for system"
  task :evolutions => :environment do 
    puts 'Gathering evolutions...'
    puts 'It should take a while...'
    (1..78).each do |evolution_id|
      response = HTTParty.get("https://pokeapi.co/api/v2/evolution-chain/#{evolution_id}")
      pokemon_evolution_response = JSON.parse(response.to_s)
      evolution_chain = pokemon_evolution_response["chain"]

      # parses pokemon name
      pokemon_name = evolution_chain["species"]["name"]
      # fetches the first pokemon in chain
      pokemon = Pokemon.find_by(name: pokemon_name)
      have_evolution(evolution_chain, pokemon)
    end
    puts 'All done!'
  end

  def save_evolution(evolution_name = "", pokemon)
    if evolution_name
      pokemon_evolution_name = evolution_name
      pokemon_evolution = Pokemon.find_by(name: pokemon_evolution_name)
      pokemon.evolutions << pokemon_evolution unless pokemon_evolution.nil? || pokemon.nil?
    end
    Pokemon.find_by(name: evolution_name)
  end

  def save_second_evolution(next_evolution_name = "", pokemon)
    if next_evolution_name
      pokemon_evolution_name = next_evolution_name
      pokemon_evolution = Pokemon.find_by(name: pokemon_evolution_name)
      pokemon.evolutions << pokemon_evolution unless pokemon_evolution.nil?
    end
  end

  def have_evolution(evolution_chain, pokemon)
    unless evolution_chain["evolves_to"].empty?
      evolution_name = evolution_chain["evolves_to"][0]["species"]["name"] 
      pokemon2 = save_evolution(evolution_name, pokemon)
      
      have_another_evolution(evolution_chain, pokemon2)
    end
  end
  
  def have_another_evolution(evolution_chain, pokemon)
    unless evolution_chain["evolves_to"][0]["evolves_to"].empty? 
      next_evolution_name = evolution_chain["evolves_to"][0]["evolves_to"][0]["species"]["name"] 
      save_second_evolution(next_evolution_name, pokemon)
    end
  end

end