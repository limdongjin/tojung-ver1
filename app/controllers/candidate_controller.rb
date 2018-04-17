class CandidateController < ApplicationController
  def index
  end
  
  # POST /candidate/create/:propose_id
  def create
    # 후보자 등록 액션
	if current_vuser.category != "국회의원"
	   redirect_to '/'
	   return
	end
    
	candidate = Vcandidate.new
    candidate.propose_id = params[:propose_id].to_i
	candidate.seller_id = Vseller.find_by_user_id(current_vuser.id).id
    candidate.user_id = current_vuser.id
	candidate.vote_num = 0
	candidate.intro = params[:intro]
	candidate.save

	if params[:plege1] != ""
		pledge1 = Vpledge.new
		pledge1.content = params[:pledge1]
		pledge1.propose_id = params[:propose_id].to_i
		pledge1.candidate_id = params[:candidate_id].to_i
		pledge1.user_id = candidate.user_id
		pledge1.seller_id = candidate.seller_id
        pledge1.status = "미이행"
		pledge1.save
	end
    redirect_to '/propose/' + params[:propose_id]
  end
  
  # GET /candidate/new/:propose_id
  def new
    # 후보자 등록 페이지
	if current_vuser.category != "국회의원"
	   redirect_to '/'
	   return
	end
    
	@propose = Vpropose.find(params[:propose_id].to_i)
  end

  def delete
  end

  def update
  end

  def edit
  end

  def detail
  end
end
