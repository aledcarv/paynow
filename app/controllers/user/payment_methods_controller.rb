class User::PaymentMethodsController < User::UserController
    before_action :authenticate_user!, only: %i[index show]

    def index
        @payment_methods = PaymentMethod.available
    end

    def show
        @payment_method = PaymentMethod.find(params[:id])
    end
end