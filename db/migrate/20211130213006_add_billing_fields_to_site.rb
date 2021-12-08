class AddBillingFieldsToSite < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :customer_stripe_id, :string
    add_column :sites, :has_valid_card, :boolean, default: false
  end
end
