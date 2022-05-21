# frozen_string_literal: true

class User < ApplicationRecord
  has_one :player, dependent: :destroy

  accepts_nested_attributes_for :player

  # ActiveStorage
  has_one_attached :avatar

  # DEVISE
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # PAY
  pay_customer

  def add_tokens!(added_tokens)
    update(tokens: tokens + added_tokens)
  end

  def remove_tokens!(removed_tokens)
    update(tokens: tokens - removed_tokens)
  end

  def admin?
    email == 'admin@sportify.com'
  end
end
