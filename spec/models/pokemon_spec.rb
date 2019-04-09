require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  context 'when testing associations...' do
    it { is_expected.to have_many(:evolutions) }
  end
end
