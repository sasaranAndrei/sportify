# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    # TODO: move to a constant - model file
    sportify_coin_stripe_id = 'price_1KaKnXG0cbVdinhJ2k7yqKsz'

    current_user.set_payment_processor :stripe

    @checkout_session = current_user.payment_processor.checkout(
      mode: 'payment',
      line_items: [
        { 
          price: sportify_coin_stripe_id,
          quantity: 2
        }
      ]
    )
  end
end
