class AddPasswordDigestToSites < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :password_digest, :string
  end
end
