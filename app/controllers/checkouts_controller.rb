# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_amount, only: :show

  def new
    puts Stripe.api_key
  end

  def show
    # TODO: move to a constant - model file
    sportify_coin_stripe_id = 'price_1KaKnXG0cbVdinhJ2k7yqKsz'

    current_user.set_payment_processor :stripe

    @checkout_session = current_user.payment_processor.checkout(
      mode: 'payment',
      success_url: success_checkout_url,
      cancel_url: cancel_checkout_url,
      line_items: [
        {
          price: sportify_coin_stripe_id,
          quantity: @order_amount
        }
      ]
    )
  end

  def success
    session = Stripe::Checkout::Session.retrieve(params[:session_id])

    # TODO: change to player
    # customer = Stripe::Customer.retrieve(session.customer)

    @added_amount = session.amount_total / 100
    current_user.add_tokens(@added_amount)
  end

  def cancel; end

  private

    def set_order_amount
      @order_amount = params[:order_amount] || 2
    end
end
