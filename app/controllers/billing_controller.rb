class BillingController < ApplicationController
  include Billing

  def index

  end

  def create
    handle_stripe_subscriptions do
      unless current_site.customer_stripe_id?
      customer = Stripe::Customer.create({source:params[:stripeToken] ,name: current_site.name})
      current_site.update(customer_stripe_id: customer.id) 
      end

      # => create subscription
      price = look_up_prices(['premium']).first
      subscription = Stripe::Subscription.create({
                                                   customer: current_site.customer_stripe_id,
                                                   items: [
                                                     {price: price.id }
                                                   ]
                                                 })
      print subscription
      if subscription.status == "active"
        current_site.update(premium:true, subscription_id: subscription.id)
        redirect_to "/#{current_site.name}",notice: "Subcription Successful"
      else
        redirect_to "/#{current_site.name}",notice: "Something went wrong"
      end
    end

  end


  def destroy
    @site = Site.find(params[:id])
    subscription = Stripe::Subscription.delete(
      @site.subscription_id,
      )
    if @site.update(subscription_id: nil, premium: false )
      redirect_to "/#{@site.name}",notice: "Subscription Removed"
    else
      redirect_to "/#{@site.name}",notice: "Something went wrong, please contact support"
    end
  end

end
