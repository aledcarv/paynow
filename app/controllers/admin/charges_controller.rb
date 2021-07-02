class Admin::ChargesController < Admin::AdminController
    before_action :set_charge, only: %i[show update]

    def index
        @charges = Charge.all
    end

    def show
    end

    def update
        if @charge.update(charge_params) && @charge.approved?
            Receipt.create!(charge: @charge, due_date: @charge.due_date, paid_date: Date.current)
            redirect_to admin_charge_path(@charge), notice: t('.success')
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