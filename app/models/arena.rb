class Arena < ApplicationRecord
  has_many :fields, dependent: :destroy

  validates :title, presence: true
  validates :location, presence: true
  # TechQuestion? - create some PhoneNumberValidator
  validates :phone_number, presence: true,
                           format: { with: Regex::ROMANIAN_PHONE_NUMBER },
                           uniqueness: true


end
