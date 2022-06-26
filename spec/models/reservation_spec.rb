require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it 'has a valid factory' do
    expect(build(:reservation)).to be_valid
  end

  describe 'Class methods' do
    describe '.has_passed?' do

    end
  end
end
