class User::ProductsController < User::UserController
    before_action :authenticate_user!
    before_action :set_company, only: %i[show index new create edit update destroy]
    before_action :set_product, only: %i[show edit update destroy]

    def index
        @products = Product.all
    end

    def show
    end

    def new
        @product = Product.new
    end

    def create
        @product = @company.products.build(product_params)
        @product.company = current_user.company
        if @product.save
            redirect_to [:user, @company, @product], notice: 'Produto criado com sucesso'
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @product.update(product_params)
            redirect_to [:user, @company, @product], notice: 'Produto editado com sucesso'
        else
            render :edit
        end
    end

    def destroy
        @product.destroy
        redirect_to user_company_products_path(@company), notice: 'Produto apagado com sucesso'
    end

    private

        def product_params
            params.require(:product).permit(:name, :price, :boleto_discount, :pix_discount, :card_discount, :company_id)
        end

        def set_company
            @company = Company.find(params[:company_id])
        end

        def set_product
            @product = Product.find(params[:id])
        end
end