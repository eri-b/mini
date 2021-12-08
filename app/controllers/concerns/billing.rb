module Billing
  PRODUCT_NAME = "mini_plans"
  UNIT_PRICE  = 200
  BILLING_LOGGER = Logger.new('log/billing.log')

  def list_prices
      Stripe::Price.list().map(&:lookup_key)

  end

  def look_up_prices(array)
    Stripe::Price.list({lookup_keys: array})
  end


  def handle_stripe_subscriptions(&block)
    begin

      yield block
    rescue  Stripe::InvalidRequestError => e
      handle_errors(e)
    rescue Stripe::CardError => e
      handle_errors(e)
    rescue Stripe::StripeError => e
      handle_errors(e)
    end
  end

  def handle_errors(e)
    BILLING_LOGGER.error(e)
  end



  module Loggers
    STRIPE_LOGGER = Logger.new('log/stripe_events.log')
  end
  # Helper
  module Helpers
    # frozen_string_literal: true

      # @param [Object] site active record instance
      # @return [Hash] with card details
      def payment_method(user)

        payment_methods = Stripe::PaymentMethod.list({
                                                       customer:  user.stripe_cus_id,
                                                       type: 'card',
                                                     })

        retrieve_payment_method = Stripe::PaymentMethod.retrieve(payment_methods.data[0].id )
        pm = retrieve_payment_method.card

        #=> can no long retrieve customer data like this
        {
          card: "xxxx-xxxx-#{pm.last4}",
          brand: pm.brand.downcase,
          country: pm.country,
          cvc_check: pm.checks.cvc_check,
          card_type: pm.funding,
          exp_month: pm.exp_month,
          exp_year: pm.exp_year,

        }
      end

    def remove_card(site)
      pm = Stripe::PaymentMethod.list({ customer:  site.stripe_cus_id, type: 'card' })
      Stripe::PaymentMethod.detach(pm.data[0].id)

      site.update_attribute(:has_valid_card, false)
    end


    def has_payment_method?(site)
      !Stripe::PaymentMethod.list({customer: site.stripe_cus_id, type: "card"}).data.empty?
    end

  end
end