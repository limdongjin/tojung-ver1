class CommentsController < ApplicationController
  def create
	@comment = Vcomment.new
	@comment.content = params[:content]
	@comment.user_id = current_vuser.id
	@comment.vproduct_id = params[:product_id].to_i
	print(@comment)
	print(@comment.save)
	print(@comment.errors)
    # redirect_back(fallback_location: root_path)
  end

  def destroy
	@comment = Vcomment.find(params[:id].to_i)
	if @comment.user_id == current_vuser.id
		@comment.destroy
		redirect_back(fallback_location: root_path)
	else
		    redirect_back(fallback_location: root_path)
	end
  end
end
