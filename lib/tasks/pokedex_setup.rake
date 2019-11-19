# frozen_string_literal: true

# This task handles database population w/ requests to PokeAPI

namespace :pokedex_setup do
  desc 'Pokedex pokemons setup for system'
  task pokemon: :environment do
    # Sets pokemon limit

    (1..151).each do |pokemon|
      # Makes http request to pokemon API
      response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{pokemon}")
      pokemon_data = JSON.parse(response.to_s)

      # Recognizes types from each pokemon and save in database
      types = []
      pokemon_data['types'].each do |pokemon_type|
        types << Type.find_or_create_by(description: pokemon_type['type']['name'])
      end

      moves = []
      pokemon_data['moves'][0...4].each do |pokemon_move|
        moves << Move.find_or_create_by(name: pokemon_move['move']['name'])
      end

      stats = []
      pokemon_data['stats'].each do |pokemon_move|
        stats << Stat.find_or_create_by(name: pokemon_move['stat']['name'],
                                        value: pokemon_move['base_stat'].to_i)
      end

      # Creates a pokemon in db based on JSON response and accumulated types
      Pokemon.create!(name: pokemon_data['name'],
                      standard_image: pokemon_data['sprites']['front_default'],
                      height: pokemon_data['height'].to_i,
                      weight: pokemon_data['weight'].to_i,
                      types: types,
                      stats: stats,
                      moves: moves)
    end
  end

  desc 'Pokedex evolutions setup for system'
  task evolutions: :environment do
    (1..78).each do |evolution_id|
      # Makes http request to pokemon API to get evolutions
      response = HTTParty.get("https://pokeapi.co/api/v2/evolution-chain/#{evolution_id}")
      pokemon_evolution_response = JSON.parse(response.to_s)
      evolution_chain = pokemon_evolution_response['chain']

      # parses pokemon name
      pokemon_name = evolution_chain['species']['name']
      # fetches the first pokemon in chain
      pokemon = Pokemon.find_by(name: pokemon_name)
      have_evolution(evolution_chain, pokemon)
    end
  end

  desc 'Pokedex items setup for system'
  task items: :environment do
    (1..200).each do |item_id|
      # Makes http request to pokemon API to get evolutions
      response = HTTParty.get("https://pokeapi.co/api/v2/item/#{item_id}")
      item_response = JSON.parse(response.to_s)

      # Creates a item instance
      Item.create!(name: item_response['name'],
                   effect: item_response['effect_entries'][0]['effect'],
                   short_description: item_response['effect_entries'][0]['short_effect'],
                   description: item_response['flavor_text_entries'][2]['text'],
                   image_url: item_response['sprites']['default'])

      puts "Created #{item_id} item(s)"
    end
  end


  desc 'Pokedex abilities for system'
  task abilities: :environment do
    (1..100).each do |ability_id|
      # Makes http request to pokemon API to get evolutions
      response = HTTParty.get("https://pokeapi.co/api/v2/ability/#{ability_id}")
      ability_response = JSON.parse(response.to_s)

      # Creates a item instance
      Ability.create!(name: ability_response['name'],
                      description: ability_response['effect_entries'][0]['effect'],
                      short_description: ability_response['effect_entries'][0]['short_effect'])
      puts "Created #{ability_id} ability(ies)"
    end
  end

  def save_evolution(evolution_name = '', pokemon, pokemon_evolutions)
    if evolution_name
      pokemon_evolution_name = evolution_name
      pokemon_evolution = Pokemon.find_by(name: pokemon_evolution_name)
      pokemon_evolutions << pokemon_evolution unless pokemon_evolution.nil?

      pokemon.update(evolutions: pokemon_evolutions) unless pokemon_evolutions.empty? || pokemon.nil?
    end
    Pokemon.find_by(name: evolution_name)
  end

  def save_second_evolution(next_evolution_name = '', pokemon)
    if next_evolution_name
      pokemon_evolution_name = next_evolution_name
      pokemon_evolution = Pokemon.find_by(name: pokemon_evolution_name)
      pokemon.update(evolutions: [pokemon_evolution]) unless pokemon_evolution.nil? || pokemon.nil?
    end
  end

  def have_evolution(evolution_chain, pokemon)
    unless evolution_chain['evolves_to'].empty?
      pokemon_evolutions = []
      evolution_chain['evolves_to'].each do |evolution|
        evolution_name = evolution['species']['name']
        pokemon2 = save_evolution(evolution_name, pokemon, pokemon_evolutions)
        have_another_evolution(evolution_chain, pokemon2)
      end
    end
  end

  def have_another_evolution(evolution_chain, pokemon)
    unless evolution_chain['evolves_to'][0]['evolves_to'].empty?
      next_evolution_name = evolution_chain['evolves_to'][0]['evolves_to'][0]['species']['name']
      save_second_evolution(next_evolution_name, pokemon)
    end
  end


end
