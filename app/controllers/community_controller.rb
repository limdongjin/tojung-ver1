class CommunityController < ApplicationController
  skip_before_action :verify_authenticity_token
  # POST /communities/:propose_id
  def index
	print(params[:propose_id].to_i)
	propose_id = params[:propose_id].to_i
	print(propose_id)
	print("\n")
    res = Vcommunity.where(propose_id: propose_id)
	print("\n")

	print(res.count)
    if res.count == 0
      render :json => { "count" => 0 }
	  return
	end
    resdict = {  }
	resdict["count"] = res.count
    res.each do |r|
      resdict[r.id] = {  }
	  resdict[r.id]["object"] = r
	  resdict[r.id]["title"] = r.title
	  resdict[r.id]["writer"] = {  }
	  resdict[r.id]["writer"]["object"] = Vuser.find(r.user_id)
      resdict[r.id]["writername"] = Vuser.find(r.user_id).name
	  resdict[r.id]["heart"] = r.heart
	end
	render :json => resdict
  end

  # skip_before_action :verify_authenticity_token
  # POST /community/new
  def new
      # render :html => 'propose/community_create' # index.html.erb
      respond_to do |format|
        # format.js
        format.html
      end

  end

 # POST /api/community/:id
 def apidetail
   id = params[:id]
   @c = Vcommunity.find(id.to_i)
   print(current_vuser)
   print(current_vuser)
   if current_vuser != nil
     @heart = Vheartlog.where(target_category: "community", target_id: @c.id, user_id: current_vuser.id ).count
   else
	 print(current_vuser)
	 print(vuser_signed_in?)
     @heart = -100
   end
   @posts = Vcpost.where(community_id: @c.id)
   if @posts.count == 0
     @res_posts = {  }
   else
   @res_posts = {  }
   @res_posts["objects"] = @posts
     @posts.each do |post|
       @res_posts[post.id] = {  }
	   @res_posts[post.id]["object"] = post
	   @res_posts[post.id]["writer"] = Vuser.find(post.user_id)
     end
   end
   @writer = Vuser.find(@c.user_id)
   render :json => { "detail": @c, "heart": @heart, "posts": @res_posts, "writername": @writer.name }
 end

  # POST /community/create/:id
  def create
	print(current_vuser)
    if current_vuser == nil or !(Vpropose.exists? params[:id])
	   print("nnn")
	   redirect_to '/propose/' + params[:id]
       # render :json => { "fail": "fail" }
	   return
	end
    print(params[:community_content])
	print(params)
	comu = Vcommunity.new
	comu.title = params[:community_title]
    comu.content = params[:community_content]
	comu.user_id = current_vuser.id
	comu.propose_id = params[:id]
	comu.image = params[:community_image]
	comu.heart = 0
	comu.save

    print("okkkk")

	redirect_to '/propose/' + params[:id]

	# render :json => { "success": comu }
  end

  # GET /community/:id
  def detail
  	# 청원 세부 정보 페이지
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

    @comu = Vcommunity.find(params[:id].to_i)
    if current_vuser != nil and Vheartlog.where(target_category: "community", target_id: params[:id].to_i, user_id: current_vuser.id).count != 0
      @ishearton = true
	else
      @ishearton = false
	end

	@writer = Vuser.find(@comu.user_id)
	@dict_comu_user = {  }
	@cposts = Vcpost.where(community_id: @comu.id)
	@cposts.each do |cp|
      @dict_comu_user[cp.user_id] = Vuser.find(cp.user_id)
	end
  end

  def edit
  end

  def update
  end

  # POST /community/:id/post
  def crepost
    if current_vuser == nil or !(Vcommunity.exists? params[:id].to_i)
       return
	end
    print("ok")
    vc = Vcommunity.find(params[:id].to_i)
    print("ok2")
    Vcpost.create(user_id: current_vuser.id, community_id: vc.id,  propose_id: vc.propose_id,
				  content: params[:cpost_content], like: 0)
    print("ok3")
    respond_to do |format|
       format.js
       format.html
     end
    return
  end

  # POST /community/cheart/:id
  def cheart
    if current_vuser == nil or !(Vcommunity.exists? params[:id].to_i)
       return
	end

    vheart = Vheartlog.where(target_id: params[:id].to_i, target_category: "community", user_id: current_vuser.id,
							 propose_id: Vcommunity.find(params[:id].to_i).propose_id )
	vc = Vcommunity.find(params[:id].to_i)
	if vheart.count != 0
      # 하트 취소
	  print("Heart Destroy")
	  vheart.each do |vh|
        vh.destroy
	  end
	  vc.heart -= 1
	  vc.save

	  render :json => { "success" => "Delete Heart" }
	  return
	else
      # 하트 누르기
	  print("Heart")
	  Vheartlog.create(target_id: params[:id], target_category: "community", user_id: current_vuser.id, propose_id: vc.propose_id)
	  vc.heart += 1
      vc.save

	  render :json => { "success" => "Create Heart" }
	  return
	end
  end

  def pheart
  end
end
