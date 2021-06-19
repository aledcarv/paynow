class User::CardMethodsController < User::UserController
    before_action :authenticate_user!, only: %i[new edit]
    before_action :set_payment_method, only: %i[new create edit update destroy]
    before_action :set_card_method, only: %i[edit update destroy]

    def new
        @card_method = CardMethod.new
    end

    def create
        @card_method = @payment_method.card_methods.build(card_method_params)
        @card_method.company = current_user.company
        @card_method.payment_method = @payment_method 
        if @card_method.save
            redirect_to user_company_path(current_user.company_id), notice: 'Meio de pagamento selecionado'
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @card_method.update(card_method_params)
            redirect_to user_company_path(current_user.company_id), notice: 'Meio de pagamento editado'
        else
            render :edit
        end
    end

    def destroy
        @card_method.destroy
        redirect_to user_company_path(current_user.company_id), notice: 'cartão apagado com sucesso'
    end

    private

        def card_method_params
            params.require(:card_method).permit(:card_code, :company_id, :payment_method_id)
        end

        def set_payment_method
            @payment_method = PaymentMethod.find(params[:payment_method_id])
        end

        def set_card_method
            @card_method = CardMethod.find(params[:id])
        end
end