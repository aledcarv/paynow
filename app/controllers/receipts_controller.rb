class ReceiptsController < ApplicationController
    def show
        @receipt = Receipt.find_by!(authorization_code: params[:authorization_code])
    end
end