class ProposeController < ApplicationController
  
  # GET /propose/index
  def index
	# 청원 목록 페이지 ( 테스트용 )
    @proposes= Vpropose.all
	
  end
  
  # GET /propose/:id
  def detail
	# 청원 세부 정보 페이지
	@propose = Vpropose.find(params[:id].to_i)
	
	# 청원 상태 정보 업데이트
	if @propose.deadlines - Time.now <= 0
	    lll =  [ "펀딩진행중", "펀딩 마감 하루전", "펀딩 마감 이틀전" ]
		lll.each do |l|
			if l == @propose.status
				@propose.status = "매칭진행중"
			end
		end
	elsif @propose.deadlines - Time.now <= (60*60*24)
		@propose.status = "펀딩 마감 하루전"
	elsif @propose.deadlines - Time.now <= (60*60*24)*2
		@propose.status = "펀딩 마감 이틀전"
	end
	@propose.save
    
	# 국회의원 정보
	if @propose.status == "입법진행중" or @propose.status == "법안심사"
		@sellers = [ ]
		Vmatch.where(propose_id: @propose.id).each do |vmatch|
			@sellers.push( Vseller.find(vmatch.seller_id) )
		end
	end
    @candidates = Vcandidate.where(propose_id: @propose.id)
	@votes = Vvote.where(propose_id: @propose.id)
	@dict_candidate = {  }
	
	@candidates.each do |candidate|
		@dict_candidate[candidate.id] = { }
		@dict_candidate[candidate.id] = { "name": Vseller.find(candidate.seller_id).name , "info": ""  }
	end

    @writer = Vuser.find(@propose.user_id)

	# 약정자 정보
	@contracts = Vcontract.where(propose_id: @propose.id)
	@dict = { }
	@contracts.each do |contract|
		@dict[contract.user_id] = Vuser.find(contract.user_id).real_name 
	end
	
	# 투표권 여부 체크.
	@ispossibleVote = FALSE
    
	if current_vuser != nil and Vvote.where(propose_id: @propose.id, user_id: current_vuser.id).count == 0
		@ispossibleVote = TRUE
	elsif current_vuser != nil and Vvote.where(propose_id: @propose.id, user_id: current_vuser.id).count != 0
        @myseller_id = Vvote.where(propose_id: @propose.id, user_id: current_vuser.id)[0].candidate_id
	end
     
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
	@propose.funded_num = 1
	@propose.save
	
	# 약정 생성
    @contract = Vcontract.new
	@contract.content = params[:contract_content]
	@contract.contract_money = params[:contract_money].to_i
	@contract.user_id = current_vuser.id
	@contract.propose_id = @propose.id
	
	@propose.deadlines = @propose.created_at + 60*60*24*30 # 한달

	@propose.funded_num = 1
	@propose.funded_money = @contract.contract_money 
	@contract.real_pay = 0
	
	@propose.save
	@contract.save
	@writer  = Vuser.find(@contract.user_id)	
	# 청원 페이지로 이동
	# redirect_to '/'
  end
  
  # GET /propose/edit/:id
  def edit
	@propose = Vpropose.find(params[:id].to_i)
    if @propose.user_id != current_vuser.id
       redirect_to '/'
	   return
	end
  end

  # POST /propose/update/:id
  def update
    @propose = Vpropose.find(params[:id].to_i)
	if @propose.user_id != current_vuser.id
       redirect_to '/'
	   return
	end
	@propose.title   = params[:propose_title] 
	@propose.content = params[:propose_content] 
	@propose.image   = params[:propose_image]

	# @propose.bg_category_name = params[:propose_bg_category]
	# @propose.sm_category_name = params[:propose_sm_category]
	
	# @propose.funded_money = 0
    # @propose.goal_money = 10000000
	# @propose.funded_num = 0
	@propose.save
	
	redirect_to '/propose/'+ @propose.id.to_s
  end

  def delete
  end
end
