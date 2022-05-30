class Tshirt < ApplicationRecord
  include Sellable
  extend Sellable

  COLORS = %w(white green red blue maroon orange).freeze

  belongs_to :player

  # TechQuestion? - How can I extract this common behaviour in a ColorValidator
  validates :color, inclusion: { in: COLORS }

  def self.sample
    # TechQuestion? - Add @@sample ||= ?
    Tshirt.new(
      nickname: 'Sampleinho',
      number: 10,
      color: 'orange',
      size: 'L'
    )
  end

  def price
    80
  end

  def photo

  end
end
