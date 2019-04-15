require 'rails_helper'
require 'task_helper'

RSpec.describe Pokemon, type: :model do
  # Constants
  POKEMON_NUMBER = 151

  context 'when testing associations...' do
    it { is_expected.to have_many(:evolutions) }
    it { is_expected.to have_many(:types).through(:pokemon_types) }
    it { is_expected.to have_many(:pokemon_types) }
  end

  context 'when testing validations...' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:image_url) }
  end


  context 'TASK: when testing tasks...' do
    describe "pokedex_setup:pokemon" do
      it "saves first 151 pokemons in db" do
        VCR.use_cassette("pokemons/species") do
          execute_rake("pokedex_setup.rake", "pokedex_setup:pokemon")
          expect(Pokemon.count).to eq POKEMON_NUMBER
        end
      end
  
      it "creates types in db" do
        VCR.use_cassette("pokemons/species") do
          execute_rake("pokedex_setup.rake", "pokedex_setup:pokemon")
          expect(Type.all.length).to be > 0
        end
      end
    end

    describe "pokedex_setup:evolution" do
      it "adds evolutions to pokemons" do
        VCR.use_cassette("pokemons/evolutions") do
          type = Type.create(description: 'grass')
          pokemon = Pokemon.create(name: 'bulbassaur', image_url: 'www.com', types: [type])
          execute_rake("pokedex_setup.rake", "pokedex_setup:evolutions")
          byebug
          expect(pokemon.evolutions.length).to eq 1
        end
      end
  
      it "adds evolutions to pokemon's evolution" do
        VCR.use_cassette("pokemons/evolutions") do
          execute_rake("pokedex_setup.rake", "pokedex_setup:evolutions")
          evolution = Pokemon.first.evolutions.drop(1)
          expect(evolution.evolutions.length).to eq 1
        end
      end
    end
  end
end
