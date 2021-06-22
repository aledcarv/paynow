class CreateFinalClientCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :final_client_companies do |t|
      t.references :final_client, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
