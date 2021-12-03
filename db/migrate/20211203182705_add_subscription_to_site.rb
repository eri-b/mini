class AddSubscriptionToSite < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :subscription_id, :string
  end
end
