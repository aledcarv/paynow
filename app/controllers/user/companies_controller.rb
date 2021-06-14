class User::CompaniesController < User::UserController
    def new
        @company = Company.new
    end

    def create
        @company = Company.new(company_params)

        if @company.save
            current_user.company_admin!
            current_user.company = @company
            current_user.save
            redirect_to [:user, @company]
        else
            render :new
        end
    end

    def show
        @company = Company.find(params[:id])
    end

    private

        def company_params
            params.require(:company).permit(:name, :cnpj, :financial_adress, :financial_email)
        end
end