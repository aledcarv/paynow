class CreateCardMethods < ActiveRecord::Migration[6.1]
  def change
    create_table :card_methods do |t|
      t.string :card_code
      t.belongs_to :company, null: false, foreign_key: true
      t.belongs_to :payment_method, null: false, foreign_key: true

      t.timestamps
    end
  end
end
