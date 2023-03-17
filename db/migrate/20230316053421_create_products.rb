class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :starting_bid_price, null: false
      t.datetime :bidding_expiration
      t.integer :bidding_status, default: 1
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
