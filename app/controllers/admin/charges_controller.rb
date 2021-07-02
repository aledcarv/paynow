class Admin::ChargesController < Admin::AdminController
    before_action :authenticate_admin!, only: %i[index show]
    before_action :set_charge, only: %i[show update]

    def index
        @charges = Charge.all
    end

    def show
    end

    def update
        if @charge.update(charge_params) && @charge.aprovado?
            Receipt.create!(charge: @charge, due_date: @charge.due_date, paid_date: Date.current)
            redirect_to admin_charge_path(@charge), notice: 'Status da cobrança atualizado com sucesso'
        end
    end

    private

        def charge_params
            params.require(:charge).permit(:status)
        end

        def set_charge
            @charge = Charge.find(params[:id])
        end
end