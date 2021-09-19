class PremiumController < ApplicationController
  include ApplicationHelper
  def index; end

  def create
    @total = params[:price].to_i * 100

    @session = Stripe::Checkout::Session.create(
      line_items: [{
        name: 'Tip à l’équipe committi',
        quantity: 1,
        currency: 'eur',
        amount: @total,
      }],
      payment_method_types: ['card'],
      success_url: premium_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: premium_cancel_url
    )
    redirect_to @session.url
  end

  def success
    premiumize_user
    flash[:notice] = 'Tips bien reçu. Merci pour votre soutien.'
    redirect_to authenticated_root_path
  end

  def cancel
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end
end
