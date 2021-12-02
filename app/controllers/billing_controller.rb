class BillingController < ApplicationController
  include Billing

  def index

  end

  def create
    handle_stripe_subscriptions do
      customer = Stripe::Customer.create({source:params[:stripeToken] ,name: current_site.name})
      current_site.update(customer_stripe_id: customer.id)

      # => create subscription
      price = look_up_prices(['premium']).first
      subscription = Stripe::Subscription.create({
                                                   customer: current_site.customer_stripe_id,
                                                   items: [
                                                     {price: price.id }
                                                   ]
                                                 })
      print subscription
      # if subscription.status == "active"
        current_site.update(premium:true)
        redirect_to "/#{current_site.name}",notice: "Subcription Successful"
      # else
      #   redirect_to "/#{current_site.name}",notice: "Something went wrong"
      # end
    end

  end

end
