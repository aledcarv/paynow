class User::BoletoMethodsController < User::UserController
    def show
        @boleto_method = BoletoMethod.find(params[:id])
    end

    def new
        @payment_method = PaymentMethod.find(params[:payment_method_id])
        @boleto_method = BoletoMethod.new
    end

    def create
        @payment_method = PaymentMethod.find(params[:payment_method_id])
        @boleto_method = @payment_method.boleto_methods.build(boleto_method_params)
        @boleto_method.company = current_user.company
        @boleto_method.payment_method = @payment_method
        if @boleto_method.save
            redirect_to user_company_path(current_user.company_id), notice: 'Meio de pagamento selecionado'
        else
            render :new
        end
    end

    def edit
        @payment_method = PaymentMethod.find(params[:payment_method_id])
        @boleto_method = BoletoMethod.find(params[:id])
    end

    def update
        @payment_method = PaymentMethod.find(params[:payment_method_id])
        @boleto_method = BoletoMethod.find(params[:id])
        if @boleto_method.update(boleto_method_params)
            redirect_to user_company_path(current_user.company_id), notice: 'Meio de pagamento editado'
        else
            render :edit
        end
    end

    private

        def boleto_method_params
            params.require(:boleto_method).permit(:bank_code, :agency_number, :bank_account, :payment_method_id, :company_id)
        end
end