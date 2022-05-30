class Ball < ApplicationRecord
  include Sellable
  extend Sellable

  COLORS = %w(white green red).freeze

  belongs_to :player
  # has_one_attached :photo # TODO: improvement

  validates :color, inclusion: { in: COLORS }

  def self.sample
    Ball.new(color: 'red')
  end

  def price
    120
  end

  def photo
    'products/ball-white.jpg'
  end
end
