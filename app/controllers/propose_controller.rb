class ProposeController < ApplicationController
  
  # GET /propose/index
  def index
    @proposes= Vpropose.all
  end

  # GET /propose/new
  def new
    # 청원 생성 페이지
	if current_vuser == nil
		redirect_to '/'
		return
	end

  end
  
  # POST /propose/create
  def create
	# 청원 생성 액션 및 약정 생성 액션
	  
	# Requset Params = { :propose_title, :propose_content, :propose_image, 
	#            :propose_bg_category, :propose_sm_category, :contract_content, :contract_money,
	# }           
	if current_vuser == nil
		redirect_to '/'
		return
	end
	
	# 청원 생성
	@propose = Vpropose.new
	@propose.title   = params[:propose_title]
	@propose.content = params[:propose_content]
	@propose.image   = params[:propose_image]
	@propose.user_id = current_vuser.id
	@propose.status  = "펀딩진행중"

	@propose.bg_category_name = params[:propose_bg_category]
	@propose.sm_category_name = params[:propose_sm_category]
	
	@propose.funded_money = 0
    @propose.goal_money = 10000000
	@propose.funded_num = 0
	@propose.save
	
	# 약정 생성
    @contract = Vcontract.new
	@contract.content = params[:contract_content]
	@contract.contract_money = params[:contract_money].to_i
	@contract.user_id = current_vuser.id
	@contract.propose_id = @propose.id

	@propose.funded_num = 1
	@propose.funded_money = @contract.contract_money 
	@propose.real_pay = 0
	
	@propose.save
	@contract.save
	
	# 청원 페이지로 이동
	redirect_to '/'
  end

  def edit
  end

  def update
  end

  def delete
  end
end
