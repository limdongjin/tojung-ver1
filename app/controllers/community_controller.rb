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

  def edit
  end

  def update
  end
  
  # POST /community/cheart/:community_id
  def cheart
    if current_vuser == nil or !(Vcommunity.exists? params[:id])
       return
	end

    vheart = Vheartlog.where(target_id: params[:community_id].to_i, target_category: "community", user_id: current_vuser.id, 
							 propose_id: Vcommunity.find(params[:id].to_i).propose_id ) 
	if vheart.count != 0
      # 하트 취소
	  print("Heart Destroy")
	  vheart.each do |vh|
        vh.destroy
	  end
	  render :json => { "success" => "Delete Heart" }
	  return
	else 
      # 하트 누르기
	  print("Heart")
	  Vheartlog.create(target_id: params[:community_id], target_category: "community", user_id: current_vuser.id)
	  render :json => { "success" => "Create Heart" }
	  return 
	end 
  end

  def pheart
  end
end
