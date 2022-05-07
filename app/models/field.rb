class Field < ApplicationRecord
  belongs_to :arena
  belongs_to :sport

  def place
    "#{label}, #{arena.title}"
  end
end
