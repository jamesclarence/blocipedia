class RemovePrivateFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :private, :boolean
  end
end
