class VoteController < ApplicationController
  def index
  end

  def new
  end
  
  # POST /vote/create/:id
  def create
	print("GOOO")
	print(params[:id])
	if !(Vcandidate.exists? params[:id].to_i) or current_vuser == nil
       return
	end

    if Vvote.where(propose_id: Vcandidate.find(params[:id].to_i).propose_id, user_id: current_vuser.id).count != 0
       return 
	end
	
	Vvote.create(candidate_id: params[:id].to_i, user_id: current_vuser.id, propose_id: Vcandidate.find(params[:id].to_i).propose_id)
	candidate= Vcandidate.find(params[:id].to_i)
	candidate.vote_num = candidate.vote_num + 1
	candidate.save

	render :json => {"name" => "Hello world"}
  end
end
