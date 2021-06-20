class User::ProductsController < User::UserController
    def index
        @company = Company.find(params[:company_id])
        @products = Product.all
    end

    def show
        @company = Company.find(params[:company_id])
        @product = Product.find(params[:id])
    end

    def new
        @company = Company.find(params[:company_id])
        @product = Product.new
    end

    def create
        @company = Company.find(params[:company_id])
        @product = @company.products.build(product_params)
        @product.company = current_user.company
        if @product.save
            redirect_to [:user, @company, @product], notice: 'Produto criado com sucesso'
        else
            render :new
        end
    end

    private

        def product_params
            params.require(:product).permit(:name, :price, :boleto_discount, :pix_discount, :card_discount, :company_id)
        end

end