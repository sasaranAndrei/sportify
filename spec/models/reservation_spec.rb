require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it 'has a valid factory' do
    expect(build(:reservation)).to be_valid
  end

  subject(:reservation) { build(:reservation) }

  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:owner_player).class_name('Player') }
    it { is_expected.to belong_to(:field) }
    it { is_expected.to have_many(:reservation_players).dependent(:destroy) }
    it { is_expected.to have_many(:guest_players).through(:reservation_players) }
    it { is_expected.to have_many(:join_requests) }
    it { is_expected.to have_many(:join_request_players).through(:join_requests).class_name('Player') }
  end

  describe 'ActiveRecord validations' do
    # TODO: check dc crapa asta? conform byebug, exista booking_date
    it 'bla bla' do
      # byebug
    end

    # pare ca functia validate_presence_of face field-u nil? - wtf
    # it { is_expected.to validate_presence_of(:booking_date) }
    # it { is_expected.to validate_presence_of(:booking_hour) }
    # it { is_expected.to validate_uniqueness_of(:field).scoped_to(:booking_date, :booking_hour) }
  end

  describe 'Instance methods' do
    describe '#days_before_booking_date' do 
      subject { reservation.days_before_booking_date }

      shared_examples 'passed reservation' do
        it 'returns a negative number' do
          expect(subject).to be < 0
        end
      end

      context 'passed a week' do
        before do
          reservation.booking_date = 1.week.ago
        end

        it_behaves_like 'passed reservation'
      end

      context 'passed a day' do
        before do
          reservation.booking_date = 1.day.ago
        end

        it_behaves_like 'passed reservation'
      end

      context 'upcoming reservation' do
        context 'upcoming a week' do
          before do
            reservation.booking_date = 1.week.from_now
          end

          it 'returns 7 days' do
            expect(subject).to eq(7)
          end
        end

        context 'upcoming a day' do
          before do
            reservation.booking_date = 1.day.from_now
          end

          it 'returns 1 day' do
            expect(subject).to eq(1)
          end
        end
      end
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

    # TODO: oare pt astea de mai jos trebe teste? daca da, cum? :-)
    # describe '#all_players' do 
    # end
    # describe '#place' do 
    # end
    # describe '#participate?' do #?
    # end

    # Skip ca are treaba cu AR
    # TODO: check cum o facut astia de la lucru
    # describe '#free_slots' do
    #   subject { reservation.free_slots }

    #   context 'brand new reservation' do
    #     before do
    #     end

    #     it 'returns MAX_SLOTS - 1 (reservation_owner)' do
    #     end
    #   end
    # end
  end
end
