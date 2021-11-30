class BillingController < ApplicationController
  include Billing

  def index

  end

  def create
    handle_stripe_subscriptions do
      customer = Stripe::Customer.create({source:params[:stripeToken] ,name: current_site.name})
      current_site.update(customer_stripe_id: customer.id, has_valid_card: true)
      redirect_to "/#{current_site.name}",notice: "Subcription Successful"
    end

  end

end
