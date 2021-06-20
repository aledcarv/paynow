class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.decimal :boleto_discount, default: 0
      t.decimal :pix_discount, default: 0
      t.decimal :card_discount, default: 0
      t.string :token
      t.belongs_to :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
