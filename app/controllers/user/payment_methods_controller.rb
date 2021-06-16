class User::PaymentMethodsController < User::UserController
    def index
        @payment_methods = PaymentMethod.available
    end

    def show
        @payment_method = PaymentMethod.find(params[:id])
    end
end