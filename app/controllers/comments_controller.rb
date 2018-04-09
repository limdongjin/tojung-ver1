class CommentsController < ApplicationController
  def create
	@comment = Vcomment.new
	@comment.content = params[:content]
	@comment.user_id = current_vuser.id
	@comment.product_id = params[:product_id]
	@comment.save

	redirect_to :back
  end

  def destroy
	@comment = Vcomment.find(params[:id])
	if @comment.user_id == current_vuser.id
		@comment.destroy
		redirect_to :back
	else
		redirect_to :back
	end
  end
end
