class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :account_id
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :subscriptions, :users
  end
end
