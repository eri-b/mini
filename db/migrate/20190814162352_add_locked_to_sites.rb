class AddLockedToSites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :locked, :boolean
  end
end
