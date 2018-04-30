class ProposeController < ApplicationController
  
  # GET /propose/index
  def index
	# 청원 목록 페이지 ( 테스트용 )
    @proposes= Vpropose.all
	
  end
  
  # GET /search_form
  def search_form
  end
  
  # GET /search?keyword=과학
  def search
    keyword = params[:keyword]
	if keyword == nil 
      redirect_to '/'
	end
    wild_keyword = "%" + keyword + "%"
	@proposes = Vpropose.where("title LIKE ?", wild_keyword)
	.or(Vpropose.where("content LIKE ?", wild_keyword)
	.or(Vpropose.where("bg_category_name LIKE ?", wild_keyword)))
    
  end
    
  # GET /propose/:id
  def detail
	# 청원 세부 정보 페이지
	print(request.base_url)
	@base_url = request.base_url
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
	@ispossibleVote = false
    
	if current_vuser != nil and Vvote.where(propose_id: @propose.id, user_id: current_vuser.id).count == 0
		@ispossibleVote = true
	elsif current_vuser != nil and Vvote.where(propose_id: @propose.id, user_id: current_vuser.id).count != 0
        @myseller_id = Vvote.where(propose_id: @propose.id, user_id: current_vuser.id)[0].candidate_id
	end
    
   # 커뮤니티 정보
   @communities = Vcommunity.where(propose_id: @propose.id)
   @dict_co = { }
   print(@communites)
   @communities.each do |comu|
      @dict_co[comu.user_id] = Vuser.find(comu.user_id)
   end
   
   
   @heart_comu = {  }
   if current_vuser != nil
      Vheartlog.where(user_id: current_vuser.id, propose_id: @propose.id, target_category: "community").each do |log|
         @heart_comu[log.target_id] = true
      end
   end

   @result = {  }
   
   @result["propose"] = {  }
   @result["propose"]["object"] = @propose
   @result["propose"]["writer"] = Vuser.find(@propose.user_id)
   
   @result["seller"] = {  }
   @result["seller"]["objects"] = Vmatch.where(propose_id: @propose.id)
   @result["seller"]["objects"].each do |obj|
     @result["seller"][obj.id] = { }
	 @result["seller"][obj.id]["user_object"] = Vuser.find(obj.user_id)
	 @result["seller"][obj.id]["candidate_object"] = Vcandidate.find(obj.candidate_id)
	 @result["seller"][obj.id]["seller_object"] = Vseller.find(obj.seller_id)
   end

   if current_vuser != nil
      votelog = Vvote.where(propose_id: @propose.id, user_id: current_vuser.id)
      if votelog.count != 0
          @result["current_vuser_vote_candidate_id"] = votelog[0].candidate_id
	  else
          @result["current_vuser_vote_candidate_id"] = -1
	  end
   else
      @result["current_vuser_vote_candidate_id"] = -100
   end 
   
   @result["candidate"] = {  }
   @result["candidate"]["objects"] = Vcandidate.where(propose_id: @propose.id)
   @result["candidate"]["objects"].each do |obj|
      @result["candidate"][obj.id] = {  }
      @result["candidate"][obj.id]["object"] = obj
	  @result["candidate"][obj.id]["user_object"] = Vuser.find(obj.user_id)
	  @result["candidate"][obj.id]["seller_object"] = Vseller.find(obj.seller_id)
   end

   @result["community"] = { }
   @result["community"]["objects"] = Vcommunity.where(propose_id: @propose.id)
   
   @result["community"]["objects"].each do |obj|
     @result["community"][obj.id] = {  }
     @result["community"][obj.id]["object"] = obj
	 @result["community"][obj.id]["writer"] = Vuser.find(obj.user_id)
	 
	 if current_vuser != nil
        @result["community"][obj.id]["current_vuser_heart"] = Vheartlog.where(target_category: "community", target_id: obj.id, user_id: current_vuser.id).count
	 else
        @result["community"][obj.id]["current_vuser_heart"] = -100
	 end

	 @result["community"][obj.id]["post"] = {  }
	 @result["community"][obj.id]["post"]["objects"] = Vcpost.where(community_id: obj.id)
     
	 @result["community"][obj.id]["post"]["objects"].each do |post|
        @result["community"][obj.id]["post"][post.id] = {  }
		@result["community"][obj.id]["post"][post.id]["object"] = post
		@result["community"][obj.id]["post"][post.id]["writer"] = Vuser.find(post.user_id)
	 end
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

	@propose.bg_category_name = params[:category_name]
	print(@propose.bg_category_name)
	#@propose.sm_category_name = params[:propose_sm_category]
	
	@propose.funded_money = 0
    @propose.goal_money = 10000000
	@propose.funded_num = 1
	@propose.save
	
	# 약정 생성
    @contract = Vcontract.new
	# @contract.content = params[:contract_content]
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
    redirect_to '/contract/'+ @contract.id.to_s
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
