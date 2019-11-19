class Api::V1::AbilitiesController < ApplicationController
  def index
    abilities = Ability.all.order(:id)
    render json: abilities, status: 200
  end
end
