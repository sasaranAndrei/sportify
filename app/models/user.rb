# frozen_string_literal: true

class User < ApplicationRecord
  has_one :player, dependent: :destroy

  accepts_nested_attributes_for :player

  # DEVISE
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # PAY
  pay_customer

  def add_tokens(added_tokens)
    update(tokens: tokens + added_tokens)
  end

  def admin?
    email == 'admin@sportify.com'
  end
end
