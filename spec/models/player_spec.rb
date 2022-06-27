require 'rails_helper'

RSpec.describe Player, type: :model do
  it 'has a valid factory' do
    expect(build(:player)).to be_valid
  end

  subject(:player) { build(:player) }

  describe 'ActiveRecord associations' do
    it { is_expected.to belong_to(:user).dependent(:destroy) }
    it { is_expected.to have_many(:own_reservations).class_name('Reservation').with_foreign_key('owner_player_id') }
    it { is_expected.to have_many(:reservation_players) }
    it { is_expected.to have_many(:guest_reservations).class_name('Reservation').through(:reservation_players) }
    it { is_expected.to have_many(:join_requests) }
    it { is_expected.to have_many(:join_request_reservations).class_name('Reservation').through(:join_requests) }
    it { is_expected.to have_many(:own_reviews).class_name('PlayerReview').with_foreign_key('player_id') }
    it { is_expected.to have_many(:guest_reviews).class_name('PlayerReview').with_foreign_key('reviewer_id') }
    it { is_expected.to have_many(:tshirts) }
    it { is_expected.to have_many(:balls) }
  end

  describe 'ActiveRecord validations' do
    # TODO
    context 'when phone_number format is invalid' do
      it { is_expected.not_to allow_value('1234567890').for(:phone_number) }
    end
  end

  describe 'ActiveRecord calllbacks' do
    it 'runs .normalize_name before validation' do
      expect(player).to receive(:normalize_name)

      player.run_callbacks(:validation)
    end
  end

  describe 'Instance methods' do
    describe '#age' do
      subject { player.age }

      before do
        player.birth_date = 20.years.ago
      end
    
      it 'returns the age of the player' do
        expect(subject).to eq(20)
      end
    end

    describe '#nickname' do
      subject { player.nickname }

      context 'when player provides a nickname' do
        before do
          player.nickname = 'Billy'
        end

        it 'returns the nickname provided by the player' do
          expect(subject).to eq('Billy')
        end
      end

      context 'when player doesn t provide a nickname' do
        it 'returns the name of the player' do
          # TechQuestion: e ok aici ca nu e o valoare hardcodata?
          # poate ca spec unei metode de genu asta trebe scris altfel
          expect(subject).to eq(player.name)
        end
      end
    end
  end
end
