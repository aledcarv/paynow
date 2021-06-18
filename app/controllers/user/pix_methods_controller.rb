class User::PixMethodsController < User::UserController
    before_action :authenticate_user!, only: %i[new edit]
    before_action :set_payment_method, only: %i[new create edit update destroy]
    before_action :set_pix_method, only: %i[edit update destroy]

    def new
        @pix_method = PixMethod.new
    end

    def create
        @pix_method = @payment_method.pix_methods.build(pix_method_params)
        @pix_method.company = current_user.company
        @pix_method.payment_method = @payment_method 
        if @pix_method.save
            redirect_to user_company_path(current_user.company_id), notice: 'Meio de pagamento selecionado'
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @pix_method.update(pix_method_params)
            redirect_to user_company_path(current_user.company_id), notice: 'Meio de pagamento editado'
        else
            render :edit
        end
    end

    def destroy
        @pix_method.destroy
        redirect_to user_company_path(current_user.company_id), notice: 'pix apagado com sucesso'
    end

    private

        def pix_method_params
            params.require(:pix_method).permit(:bank_code, :key_pix, :payment_method_id, :company_id)
        end

        def set_pix_method
            @pix_method = PixMethod.find(params[:id])
        end
        
        def set_payment_method
            @payment_method = PaymentMethod.find(params[:payment_method_id])
        end
end