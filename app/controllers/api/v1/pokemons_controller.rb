# API/V1/PokemonsController handles Pokemon's stuff requests such as CRUD operations
class Api::V1::PokemonsController < ApplicationController
  def show
    @pokemon = Pokemon.find(params[:id])
    render json: @pokemon, status: 200
  end

  def index
    @pokemons = Pokemon.all.order(:id)
    render json: @pokemons, status: 200
  end

  def create
    @pokemon = Pokemon.new(pokemon_params)

    if @pokemon.save
      render json: @pokemon, status: 200
    else
      render json: { "error": [@pokemon.errors.full_messages] }.to_json, status: 422
    end
  end

  def update
    @pokemon = Pokemon.find(params[:id])

    if @pokemon.update(pokemon_params)
      render json: @pokemon, status: 200
    else
      render json: { "error": [@pokemon.errors.full_messages] }.to_json, status: 422
    end
  end

  def destroy
    @pokemon = Pokemon.find(params[:id])
    @pokemon.destroy
    render json: { "message": "Pokemon was successfully destroyed" }, status: 200

  end

  private
  def pokemon_params
    params.permit(:name, :image_url)
  end
end
