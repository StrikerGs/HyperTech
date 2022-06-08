class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product
  
    def create

        @product.comments.create(comment_params.to_h.merge!({user_id: current_user.id}))
        redirect_to product_path(@product), notice: "O comentário foi feito com sucesso."


    end

    def destroy

        comment = @product.comments.find(params[:id])
        authorize comment

        comment.destroy
        redirect_to product_path(@product), notice: "O comentário foi apagado com sucesso."
        
    end

    private

    def comment_params

        params.require(:comment).permit(:body)

    end

    def set_product

        @product = Product.find(params[:product_id])

    end

end
