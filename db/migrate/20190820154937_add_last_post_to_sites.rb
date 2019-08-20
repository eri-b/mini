class AddLastPostToSites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :last_post, :datetime
  end
end
