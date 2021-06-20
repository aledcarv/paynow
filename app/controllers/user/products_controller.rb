class User::ProductsController < User::UserController
    def index
        @company = Company.find(params[:company_id])
        @products = Product.all
    end

    def show
        @company = Company.find(params[:company_id])
        @product = Product.find(params[:id])
    end
end