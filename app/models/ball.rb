class Ball < ApplicationRecord
  include Sellable
  extend Sellable

  COLORS = %w(white green red).freeze

  belongs_to :player

  validates :color, inclusion: { in: COLORS }

  def self.sample
    Ball.new(color: 'red')
  end

  def price
    120
  end

  def photo
    
  end
end
