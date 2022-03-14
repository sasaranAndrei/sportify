class Arena < ApplicationRecord
  has_many :fields, dependent: :destroy 
end
