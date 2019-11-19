class Api::V1::ItemsController < ApplicationController
  def index
    items = Item.all.order(:id)
    render json: items, status: 200
  end
end
