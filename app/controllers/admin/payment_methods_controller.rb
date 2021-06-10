class Admin::PaymentMethodsController < Admin::AdminController
    before_action :set_payment_method, only: %i[show edit update]

    def index
        @payment_methods = PaymentMethod.all
    end

    def show
    end

    def new
        @payment_method = PaymentMethod.new
    end

    def create
        @payment_method = PaymentMethod.new(payment_method_params)

        if @payment_method.save
            redirect_to [:admin, @payment_method]
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @payment_method.update(payment_method_params)
            redirect_to [:admin, @payment_method]
        else
            render :edit
        end
    end

    private

        def payment_method_params
            params.require(:payment_method).permit(:name, :tax_porcentage, :tax_maximum, :status, :payment_type)
        end

        def set_payment_method
            @payment_method = PaymentMethod.find(params[:id])
        end
end