class RegistController < ApplicationController
  def index
  end
  
  # GET /regist/new
  def new
    
  end
  
  # POST /regist/create
  def create
    if !(Vcode.exists? code_name: params[:special_code])
		redirect_to '/'
		return
	end
	if Vcode.where(code_name: params[:special_code])[0].status != "인증대기중"
       redirect_to '/'
	   return
	end 
    vcode = Vcode.where(code_name: params[:special_code])[0]
    #@vlast = ""
	user_id = Vuser.create(name: vcode.user_name, real_name: vcode.user_name, 
				 password: params[:password], email: params[:email], category: "국회의원").id 
    if user_id != nil  
		Vseller.create(name: vcode.user_name, user_id: user_id)
		vcode.status = "인증완료"
		vcode.user_id = user_id
		vcode.save
	end
   @user_name = vcode.user_name
  end
end
