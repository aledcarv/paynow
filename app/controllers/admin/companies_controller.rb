class Admin::CompaniesController < Admin::AdminController
    def index
        @companies = Company.all
    end

    def show
        @company = Company.find(params[:id])
    end

    def edit
        @company = Company.find(params[:id])
    end

    def update
        @company = Company.find(params[:id])

        if @company.update(company_params)
            redirect_to [:admin, @company]
        else
            render :edit
        end
    end

    def token_generator
        @company = Company.find(params[:id])
        @company.token = SecureRandom.base58(20)
        if @company.save
            redirect_to admin_company_path(@company), notice: 'token atualizado com sucesso'
        else
            redirect_to admin_company_path(@company), alert: 'A atualização falhou'
        end
    end

    private

        def company_params
            params.require(:company).permit(:name, :cnpj, :financial_adress, :financial_email)
        end
end