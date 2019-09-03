class Remove < ActiveRecord::Migration[5.2]
  def change
    remove_column :sites, :last_post
  end
end
