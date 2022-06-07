class Tshirt < ApplicationRecord
  include Sellable
  extend Sellable

  COLORS = %w(white green red blue maroon orange).freeze
  SIZES = %w(XXS XS S M L XL XXL).freeze

  belongs_to :player
  has_one_attached :photo

  # TechQuestion16? - How can I extract this common behaviour in a ColorValidator
  validates :color, inclusion: { in: COLORS }
  validates :size, inclusion: { in: SIZES }

  def self.sample
    # TechQuestion17? - Add @@sample ||= ? will improve things? Nu mai stiu dar parca am incercat si o fo ceva probleme
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
    'products/tshirt-red.png'
  end
end
