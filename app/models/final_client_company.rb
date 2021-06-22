class FinalClientCompany < ApplicationRecord
  belongs_to :final_client
  belongs_to :company

  validates :final_client_id, uniqueness: { scope: :company_id }
end
