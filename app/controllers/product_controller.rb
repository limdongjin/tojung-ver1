class ProductController < ApplicationController
   def list
      page_id = params[:page_id].to_i
      if page_id == 0
         # exception handling
		 redirect_to '/'
         return
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
	  @vpackages = Vpackage.where(product_id: params[:product_id])
      @bill = Bill.find(params[:product_id])
   end
   
   def buy
      # buy
	  if current_vuser == nil 
         # 잘못된 접근!! 
         redirect_to '/'
		 return
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
	  elsif params[:commit] == "buy"
         @product = Vproduct.find(params[:product_id])
		 @seller = Vseller.find(@product.seller_id)
		 @person = Person.find(@product.seller_id)
	  end
   end
   
   def buyok
     # buy 페이지에서 최종 구매 정보를 받아서 Vtransaction에 추가하고, Vproduct의 총 펀딩액을 추가한다. 

   end

   def cart_list
     # cart
	 if current_vuser == nil
	   #잘못된 접근
	   redirect_to '/'
	   return
     end

	 @carts = Vcart.where(user_id: current_vuser.id)
    
   end
end
