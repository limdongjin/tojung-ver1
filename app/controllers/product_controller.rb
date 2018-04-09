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
	  @comments = Vcomment.where(vproduct_id: params[:product_id])
	   
      @vproduct = Vproduct.find(params[:product_id])
	  @packages = Vpackage.where(product_id: params[:product_id])
      @bill = Bill.find(params[:product_id])
	  @package_index = [] 
	  @package_price = []
	  @packages.each do |pack|
         #@package_price_map[pack.id] = pack.price
		 @package_index.append(pack.id)
		 @package_price.append(pack.price)
	  end 
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
		 @package = Vpackage.find(params[:package_id])

		 cart = Vcart.new
		 cart.user_id = uid
		 cart.product_id = params[:product_id]
		 cart.package_id = params[:package_id]
		 cart.package_name = @package.name
		 cart.addhoo = params[:hoo]
		 cart.num = params[:package_num]
		 cart.save 

         redirect_to '/product/cart_list'
		 return
	  elsif params[:commit] == "buy"
		 
         @product = Vproduct.find(params[:product_id])
		 
		 @package = Vpackage.find(params[:package_id])
  
		 @seller = Vseller.find(@product.seller_id)
		 @person = Person.find(@product.seller_id)

		 @coupons = Vcoupon.where(user_id: uid)
		 @coupon_index = [ ]
		 @coupon_price = [ ]
		 @coupon_name  = [ ]
		 @coupons.each do |coup|
			@coupon_index.push(coup.id)
			@coupon_price.push(coup.remain_amount)
			@coupon_name.push(coup.name)
		 end
		 
		 @user = Vuser.find(uid)
	  
		 @packages = Vpackage.where(product_id: params[:product_id])
	  	 
		 @package_index = [] 
	     @package_price = []
	  	 @packages.each do |pack|
		 	@package_index.append(pack.id)
		 	@package_price.append(pack.price)
	  	 end 

		 @package_num = params[:package_num].to_i
		 
		 if @package_num == 0 
			@package_num = 0
		 end
		 
		 @hoo = params[:hoo].to_i
		 
		 @total_amount = (@package.price)*@package_num + @hoo
	  end

   end
   
   def buyok 
	 # Single Buyment
     # buy 페이지에서 최종 구매 정보를 받아서 Vtransaction에 추가하고, Vproduct의 총 펀딩액을 추가한다. 
     @transaction = Vtransaction.new

	 @transaction.serial = Vtransaction.last.serial + 1
	 @transaction.user_id = current_vuser.id
	 @transaction.product_id = params[:product_id]
     @transaction.package_id = params[:package_id] 
	 # Buy status
	 
	 if params[:hoo].to_i == 0  
		@hoo = 0
	 else
		@hoo = params[:hoo].to_i
	 end
	 
	 if params[:package_num].to_i == 0
		@package_num = 0
	 else
		@package_num = params[:package_num].to_i
	 end

	 @transaction.total_amount = Vpackage.find(params[:package_id]).price * @package_num + @hoo
	 @transaction.package_price = Vpackage.find(params[:package_id]).price 
	 @transaction.package_num = @package_num
	 @transaction.hoo = @hoo
     
	 # pay user 
	 @transaction.user_accountt = params[:user_account]
	 @transaction.user_name = params[:user_name]
	 @transaction.user_addr = params[:user_address]
	 @transaction.user_addr_num = params[:user_address_num]
	 @transaction.user_phone = params[:user_phone_number]
	 @transaction.user_email = params[:user_email]

	 # baesong info
	 @transaction.baesong_name = params[:baesong_name] 
     @transaction.baesong_addr = params[:baesong_address]
	 @transaction.baesong_addr_num = params[:baesong_address_num]
	 @transaction.baesong_contact = params[:baesong_contact]

     # payment init
     @transaction.payment_way = "무통장입금"
     @transaction.ispay = false
     @transaction.coupon = params[:coupon_id]
	 @transaction.coupon_use = params[:coupon_use] # 쿠폰을 얼마 사용 할것인지

	 if @transaction.coupon == -1
	     @transaction.received_amount = 0
	 else 
		@coupon = Vcoupon.find(@transaction.coupon)
		if @coupon.remain_amount >= @transaction.coupon_use
            @transaction.received_amount = @transaction.coupon_use
			@coupon.remain_amount = @coupon.remain_amount - @transaction.coupon_use
		end
     end

	 if @transaction.received_amount < @transaction.total_amount
	     @transaction.baesong_status = "입금대기중"
         @transaction.payed_account = "아직 입금 계좌 정보 없음"
         @transaction.payed_name = "아직 입금자 정보 없음"
	 else
         @transaction.baesong_status = "입금 완료"
		 @transaction.payed_account = "쿠폰 사용"
		 @transaction.payed_name = @transaction.user_name
	 end
	 if @transaction.coupon != -1
	   @coupon.save
	 end
	 @transaction.save
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
