class CreateCharges < ActiveRecord::Migration[6.1]
  def change
    create_table :charges do |t|
      t.decimal :original_value
      t.decimal :discount_value
      t.string :token
      t.integer :status, default: 1
      t.string :final_client_name
      t.string :final_client_cpf
      t.string :card_number
      t.string :card_printed_name
      t.string :verification_code
      t.string :address
      t.string :company_token
      t.string :product_token
      t.string :payment_method

      t.timestamps
    end
  end
end
