require 'rails_helper'

RSpec.describe Pokemon, type: :request do
  describe "when testing requests..." do
    let(:returned_json) { JSON.parse(response.body) }

    context "#index" do 
      let!(:pokemons) { FactoryBot.create_list(:pokemon, 2) }

      before do 
        get '/api/v1/pokemons', params: {}  
      end

      it "returns 200 http status for correct request" do
        expect(response).to have_http_status(200)
      end

      it "return a valid JSON with a valid pokemon collection" do
        expect(returned_json.length).to be 2
      end
    end

    context "#show" do 
      let(:factory_pokemon) { FactoryBot.create(:pokemon) }
      let(:fake_pokemon) { FactoryBot.build(:pokemon, name: '') }

      before do 
        get "/api/v1/pokemons/#{factory_pokemon.id}", params: {}  
      end

      it "returns 200 http status for correct request" do
        expect(response).to have_http_status(200)
      end

      it "return a valid JSON with a pokemon" do
        pokemon = Pokemon.find_by(name: returned_json["name"])
        expect(pokemon.nil?).to be false
      end
    end

    context "#create" do
      let(:sketch_pokemon) { FactoryBot.build(:pokemon, name: 'Bulbassaur') }
      describe "when creates correctly..." do
          before do 
            post "/api/v1/pokemons", params: { name: sketch_pokemon.name, image_url: '123.com' }
          end

          it "returns 200 http status for correct request" do
            expect(response).to have_http_status(200)
          end

          it "returns a valid JSON with a pokemon" do
            expect(Pokemon.last.name).to eq sketch_pokemon.name
          end
        end

      describe "when pokemons isnt create correctly..." do
        before do 
          post "/api/v1/pokemons/", params: { name: '' }
        end

        it "returns 422 http status for correct request" do
          expect(response).to have_http_status(422)
        end

        it "return a JSON with errors" do
          expect(returned_json["error"]).not_to be nil
        end
      end
    end

    context "#update" do
      let(:sketch_pokemon) { FactoryBot.create(:pokemon, name: 'Bulbassaur') }
      let(:updated_pokemon) { { name: 'New_Name', image_url: '123456.com'  } }

      describe "when updates correctly..." do
          before do 
            patch "/api/v1/pokemons/#{sketch_pokemon.id}"
          end

          it "returns 200 http status for correct request" do
            expect(response).to have_http_status(200)
          end

          it "returns a valid JSON with a pokemon" do
            expect(Pokemon.last.name).to eq sketch_pokemon.name
          end
        end

      describe "when pokemons isnt updated correctly..." do
        before do 
          patch "/api/v1/pokemons/#{sketch_pokemon.id}", params: { name: '' }
        end

        it "returns 422 http status for correct request" do
          expect(response).to have_http_status(422)
        end

        it "return a JSON with errors" do
          expect(returned_json["error"]).not_to be nil
        end
      end
    end

    context "#destroy" do 
      let(:sketch_pokemon) { FactoryBot.create(:pokemon, name: 'Bulbassaur') }

      before do 
        delete "/api/v1/pokemons/#{sketch_pokemon.id}", params: {}
      end

      it "deletes a pokemon from db" do 
        pokemon = Pokemon.find_by(name: "#{sketch_pokemon.name}")
        expect(pokemon.present?).to be_falsy
      end
    end
  end
end