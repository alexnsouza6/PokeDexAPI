require 'rails_helper'

RSpec.describe PokemonType, type: :model do
  describe "when testing associations..." do
    it { is_expected.to belong_to(:pokemon) }
    it { is_expected.to belong_to(:type) }
  end
end
