require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  it { is_expected.to have_many(:evolutions) }
end
