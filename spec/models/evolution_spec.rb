require 'rails_helper'

RSpec.describe Evolution, type: :model do
  context 'when testing associations' do
    it { is_expected.to belong_to(:pokemon) }
  end
end
