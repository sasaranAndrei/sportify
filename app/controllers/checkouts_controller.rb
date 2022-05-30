# frozen_string_literal: true

class CheckoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order_amount, only: :show
  before_action :set_products, only: %i[ new ]

  def new
    # @products += ['Some product', 'Other product', 'Another product']
    @products += [Ball.new, Tshirt.new, Tshirt.new]
  end

  def show
    # TODO: move to a constant - model file
    # sportify_coin_stripe_id = 'price_1KaKnXG0cbVdinhJ2k7yqKsz'

    current_user.set_payment_processor :stripe

    @checkout_session = current_user.payment_processor.checkout(
      mode: 'payment',
      success_url: success_checkout_url,
      cancel_url: cancel_checkout_url,
      line_items: [
        {
          price: ShopConfiguration::SPORTIFY_COIN_STRIPE_ID,
          quantity: @order_amount
        }
      ]
    )
  end

  def success
    flash.now[:notice] = 'Tokens added successfully!'
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    
    # TODO: change to player
    # customer = Stripe::Customer.retrieve(session.customer)
    
    @added_amount = session.amount_total / 100
    current_user.add_tokens!(@added_amount)
  end

  def cancel; end

  private

    def set_order_amount
      @order_amount = params[:order_amount].presence || ShopConfiguration::STRIPE_MINIMUM_BILL
    end

    def set_products
      type_of_products = ObjectSpace.each_object(Class)
                                    .select { |c| c.included_modules.include?(Sellable) }
                                    .map(&:name)
                                    .compact
      # byebug
      @products = type_of_products.collect { |product| product.constantize.sample }
    end
end
