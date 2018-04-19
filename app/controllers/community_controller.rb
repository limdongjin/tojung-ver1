class CommunityController < ApplicationController
  # def index
  # end

  # def new
  # end
  
  # POST /community/create/:id 
  def create
    if current_vuser == nil or !(Vpropose.exists? params[:id])
       return
	end
    
	comu = Vcommunity.new
	comu.title = params[:community_title]
    comu.content = params[:community_content]
	comu.user_id = current_vuser.id
	comu.propose_id = params[:id]
	comu.image = params[:community_image]
	comu.heart = 0
	comu.save
    
    redirect_to '/propose/' + params[:id]
  end

  # GET /community/:id
  def detail
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
