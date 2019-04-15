require 'rails_helper'

RSpec.describe Type, type: :model do
  describe "when testing associations..." do
    it { is_expected.to have_many(:pokemons).through(:pokemon_types) }
    it { is_expected.to have_many(:pokemon_types) }
  end

  describe "when testing validations..." do
    it { is_expected.to validate_presence_of(:description) }
  end
end
