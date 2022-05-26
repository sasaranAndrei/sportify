class Field < ApplicationRecord
  belongs_to :arena
  belongs_to :sport

  validates :label, presence: true
  validates :min_players, presence: true, 
                          numericality: { greater_than: 0 }
  validates :max_players, presence: true, 
                          numericality: { greater_than: :min_players }

  def place
    "#{label}, #{arena.title}"
  end
end
