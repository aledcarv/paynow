class User::CompaniesController < User::UserController
    before_action :set_company, only: %i[show edit update]

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
    end

    def edit
    end

    def update
        if @company.update(company_params)
            redirect_to [:user, @company]
        else
            render :edit
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