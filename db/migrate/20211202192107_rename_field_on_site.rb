class RenameFieldOnSite < ActiveRecord::Migration[5.2]
  def change
    rename_column :sites, :has_valid_card, :premium
  end
end
