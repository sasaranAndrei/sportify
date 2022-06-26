require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it 'has a valid factory' do
    expect(build(:reservation)).to be_valid
  end

  describe 'Instance methods' do
    # TODO: oare pt astea de mai jos trebe teste? daca da, cum? :-)
    # describe '#all_players' do 
    # end
    # describe '#place' do 
    # end
    # describe '#participate?' do #?
    # end

    describe '#days_before_booking_date' do 
      
    end

    describe '#free_slots' do

    end

    describe '#has_passed?' do
      context 'passed reservation' do
        # poate ar fii mai bine sa l mut in subject si sa fac update in before
        let(:reservation) { build(:reservation, :passed) }
        
        it 'returns true' do
          # byebug
          expect(reservation.has_passed?).to be true
        end
      end

      context 'upcoming reservation' do
        it 'return false' do
          expect(false).to be false
        end
      end
    end
  end
end
