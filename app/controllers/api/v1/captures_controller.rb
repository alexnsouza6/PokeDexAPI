class Api::V1::CapturesController < ApplicationController

  def create
    user = User.find(capture_params['user_id'])
    pokemon = Pokemon.find(capture_params['pokemon_id'])
    if user && pokemon
      user.pokemons << pokemon
      if user.save
        render json: { user: user }, status: :ok
      else
        render json: { errors: 'Unsuccessfully capture.' }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Unsuccessfully capture.' }, status: :unprocessable_entity
    end
  end

  private

  def capture_params
    params.permit(:pokemon_id, :user_id)
  end
end
