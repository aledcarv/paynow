class CreatePixMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :pix_methods do |t|
      t.string :bank_code
      t.string :key_pix
      t.belongs_to :company, null: false, foreign_key: true
      t.belongs_to :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
