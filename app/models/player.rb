# frozen_string_literal: true

class Player < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
