require 'rails_helper'

RSpec.describe Evolution, type: :model do
  context 'when testing associations...' do
    it { is_expected.to belong_to(:pokemon) }
  end
  
  context 'when testing validations...' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
