class CreateCartProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_products do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, default: 1
      t.decimal :unit_price, precision: 17, scale: 2
      t.decimal :total_price, precision: 17, scale: 2

      t.timestamps
    end
  end
end
