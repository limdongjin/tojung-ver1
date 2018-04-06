class ProductController < ApplicationController
   def list
      page_id = params[:page_id].to_i
      if page_id == 0
         # exception handling
      end
      startpoint = ( (page_id -1) * 12 )
      @vproducts = Vproduct.order(:created_at).limit(12).offset(startpoint)
      
      @bills = { }
      @vproducts.each do |vproduct|
         @bills[vproduct.id] = Bill.find(vproduct.bill_id)
      end 
   end

   def detail
      @vproduct = Vproduct.find(params[:product_id])
      @bill = Bill.find(params[:product_id])
   end
   
   def buy
      # buy
	  if current_vuser == nil 
         # 잘못된 접근!! 
         redirect_to '/'
	  else 
         uid = current_vuser.id 
      end

	  if params[:commit] == "addcart"
		 cart = Vcart.new
		 cart.user_id = uid
		 cart.product_id = params[:product_id]
		 cart.package_name = params[:package] # 임시 방편
		 #cart.package_id
		 cart.addhoo = params[:hoo]
		 #cart.num
		 cart.save 
         redirect_to '/product/cart_list'
	  end
      
      
   end

   def cart_list
     # cart
	 if current_vuser == nil
	   #잘못된 접근
	   redirect_to '/'
     end

	 @carts = Vcart.where(user_id: current_vuser.id)
    
   end
end
