class Api::V1::FinalClientsController < Api::V1::ApiController
    def create
        @company = Company.find_by(token: params[:company_token])
        @final_client = FinalClient.new(final_client_params)
        @final_client.save!
        @client_company =  FinalClientCompany.create(final_client: @final_client, company: @company)
        render json: @final_client, status: :created
    rescue ActiveRecord::RecordInvalid
        render json: @final_client.errors, status: :unprocessable_entity
    end

    private

        def final_client_params
            params.require(:final_client).permit(:name, :cpf)
        end
end