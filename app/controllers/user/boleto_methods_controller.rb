class User::BoletoMethodsController < User::UserController
    before_action :set_payment_method, only: %i[new create edit update destroy]
    before_action :set_boleto_method, only: %i[edit update destroy]

    def new
        @boleto_method = BoletoMethod.new
    end

    def create
        @boleto_method = @payment_method.boleto_methods.build(boleto_method_params)
        @boleto_method.company = current_user.company
        @boleto_method.payment_method = @payment_method
        if @boleto_method.save
            redirect_to user_company_path(current_user.company_id), notice: t('.success')
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @boleto_method.update(boleto_method_params)
            redirect_to user_company_path(current_user.company_id), notice: t('.success')
        else
            render :edit
        end
    end

    def destroy
        @boleto_method.destroy
        redirect_to user_company_path(current_user.company_id), notice: t('.success')
    end

    private

        def boleto_method_params
            params.require(:boleto_method).permit(:bank_code, :agency_number, :bank_account, :payment_method_id, :company_id)
        end

        def set_payment_method
            @payment_method = PaymentMethod.find(params[:payment_method_id])
        end

        def set_boleto_method
            @boleto_method = BoletoMethod.find(params[:id])
        end
end