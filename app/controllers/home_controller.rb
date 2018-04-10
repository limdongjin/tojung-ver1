class HomeController < ApplicationController
  def index
   if !(current_vuser.blank?)
      if current_vuser.real_name == nil or current_vuser.address == nil or current_vuser.phone_number == nil
		 redirect_to(edit_vuser_registration_path)
	  end
   end
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
