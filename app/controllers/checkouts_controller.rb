# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_amount, only: :show

  def new
  end

  def show
    # TODO: move to a constant - model file
    sportify_coin_stripe_id = 'price_1KaKnXG0cbVdinhJ2k7yqKsz'

    current_user.set_payment_processor :stripe

    @checkout_session = current_user.payment_processor.checkout(
      mode: 'payment',
      line_items: [
        { 
          price: sportify_coin_stripe_id,
          quantity: @order_amount
        }
      ]
    )
  end

  private

    def set_order_amount
      @order_amount = params[:order_amount] || 1
    end
end
