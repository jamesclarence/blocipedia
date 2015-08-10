class RemovePrivateFromWikis < ActiveRecord::Migration
  def change
    remove_column :wikis, :private, :boolean
  end
end
