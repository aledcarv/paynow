class Admin::ChargesController < Admin::AdminController
    def index
        @charges = Charge.all
    end

    def show
        @charge = Charge.find(params[:id])
    end

    def update
        @charge = Charge.find(params[:id])
        if @charge.update(charge_params) && @charge.aprovado?
            redirect_to admin_charge_path(@charge), notice: 'Status da cobrança atualizado com sucesso'
        end
    end

    private

        def charge_params
            params.require(:charge).permit(:status)
        end
end