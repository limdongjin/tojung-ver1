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

end
