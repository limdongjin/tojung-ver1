class HomeController < ApplicationController
  def index
  end

  def about
  end

  def mypage
    if (current_vuser.blank?) == true
	   redirect_to '/'
	   return
	end    
	@user = current_vuser
	@transactions = Vtransaction.where(user_id: @user.id)
	
	@pack_dict = { }
	@prod_dict = { }
	@transactions.each do |tran|
		@pack_dict[tran.id] = Vpackage.find(tran.package_id)
		@prod_dict[tran.id] = Vproduct.find(tran.product_id)
	end
	# @prodcut = Vproduct.find(@transaction.product_id)
	# @package = Vpackage.find(@.pro
  end
end
