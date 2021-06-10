class AddPaymentTypeToPaymentMethod < ActiveRecord::Migration[6.1]
  def change
    add_column :payment_methods, :payment_type, :integer, null: false
  end
end
