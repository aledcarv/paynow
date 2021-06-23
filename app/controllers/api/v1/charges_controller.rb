class Api::V1::ChargesController < Api::V1::ApiController
    def create
        @product = Product.find_by(token: params[:charge][:product_token])
        @company = Company.find_by(token: params[:charge][:company_token])
        @charge = Charge.new(charge_params)
        @charge.original_value = @product.price
        @charge.discount_value = count_value_discount
        @charge.save!

        render json: @charge.as_json(expect: %i[id created_at updated_at]), status: :created
    end

    private

        def count_value_discount
            if @charge.payment_method.eql?('boleto')
                @product.price - (@product.price * (@product.boleto_discount / 100))
            elsif @charge.payment_method.eql?('card')
                @product.price - (@product.price * (@product.card_discount / 100))
            elsif @charge.payment_method.eql?('pix')
                @product.price - (@product.price * (@product.pix_discount / 100))
            end
        end

        def charge_params
            params.require(:charge).permit(:company_token, :product_token, :final_client_name, :final_client_cpf,
                                           :payment_method, :address, :card_number, :card_printed_name, :verification_code)
        end
end