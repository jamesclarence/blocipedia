class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title
      t.text :body
      t.boolean :private
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :wikis, :users
  end
end
