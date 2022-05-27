class Ball < ApplicationRecord
  include Sellable

  COLORS = %w(white green red).freeze

  belongs_to :player

  validates :color, inclusion: { in: COLORS }

  def price
    120
  end
end
