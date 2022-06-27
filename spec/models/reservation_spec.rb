require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it 'has a valid factory' do
    expect(build(:reservation)).to be_valid
  end

  subject(:reservation) { build(:reservation) }

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

    describe '#has_passed?' do
      subject { reservation.has_passed? }

      context 'passed reservation' do
        before do
          reservation.booking_date = Date.yesterday
        end
        
        it 'returns true' do
          expect(subject).to be true
        end
      end

      context 'upcoming reservation' do
        before do
          reservation.booking_date = Date.tomorrow
        end

        it 'return false' do
          expect(subject).to be false
        end
      end
    end

    describe '#free_slots' do
      subject { reservation.free_slots }

      context 'brand new reservation' do
        before do
        end

        it 'returns MAX_SLOTS - 1 (reservation_owner)' do
          byebug
        end
      end
    end
  end
end
