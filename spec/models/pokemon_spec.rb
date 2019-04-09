require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  context 'when testing associations...' do
    it { is_expected.to have_many(:evolutions) }
  end

  context 'when testing validations...' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:image_url) }
  end
end
