class Admin::CompaniesController < Admin::AdminController
    before_action :authenticate_admin!, only: %i[index show edit]
    before_action :set_company, only: %i[show edit update token_generator]

    def index
        @companies = Company.all
    end

    def show
    end

    def edit
    end

    def update
        if @company.update(company_params)
            redirect_to [:admin, @company]
        else
            render :edit
        end
    end

    def token_generator
        @company.token = SecureRandom.base58(20)
        if @company.save
            redirect_to admin_company_path(@company), notice: t('.success')
        else
            redirect_to admin_company_path(@company), alert: t('alert')
        end
    end

    private

        def company_params
            params.require(:company).permit(:name, :cnpj, :financial_adress, :financial_email)
        end

        def set_company
            @company = Company.find(params[:id])
        end
end