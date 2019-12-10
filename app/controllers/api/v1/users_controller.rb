class Api::V1::UsersController < ApplicationController
  def create
    user = User.find_by(account_id: user_params['account_id'])
    if user.nil?
      user = User.new(user_params)
      if user.save!
        render json: user, status: :ok
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: user, status: :ok
    end
  end

  def show
    user = User.find(user_params[:id])
    if user
      render json: user, status: :ok
    else
      render json: { errors: 'User not found' }, status: :not_found
    end
  end

  private

  def user_params
    params.permit(:name, :account_id, :id)
  end
end
