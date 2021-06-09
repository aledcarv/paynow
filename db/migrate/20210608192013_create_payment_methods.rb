class CreatePaymentMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_methods do |t|
      t.string :name
      t.decimal :tax_porcentage
      t.decimal :tax_maximum
      t.boolean :status, null: false, default: false

      t.timestamps
    end
  end
end
