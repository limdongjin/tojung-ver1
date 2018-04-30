class ContractController < ApplicationController
  
  # GET /contract/:id
  def share
	@contract = Vcontract.find(params[:id].to_i) 
    @writer = Vuser.find(@contract.user_id)
	@propose = Vpropose.find(@contract.propose_id)
  end

  def index
  end
  
  # GET /contract/new/:propose_id
  def new
   if current_vuser == nil
      redirect_to '/'
	  return
   end

   @propose = Vpropose.find(params[:propose_id].to_i)
  end

  def edit
  end

  def update
  end
  
  # POST /contract/create/:propose_id
  def create
   if current_vuser == nil 
     redirect_to '/'
	 return 
   end
   @propose = Vpropose.find(params[:propose_id].to_i)

   @contract = Vcontract.new
   @contract.propose_id = @propose.id
   @contract.content = params[:content]
   @contract.user_id = current_vuser.id
   @contract.contract_money = params[:contract_money].to_i
   @contract.real_pay = 0 
   @contract.save 
   
   @writer = Vuser.find(@contract.user_id)
   
   @propose.funded_num += 1
   @propose.funded_money += @contract.contract_money
   @propose.save 

   redirect_to '/contract/' + @contract.id.to_s
  end

  def delete
  end
end
