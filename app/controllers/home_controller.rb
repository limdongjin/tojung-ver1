class HomeController < ApplicationController
  def index
  end

  def about
  end

  def mypage
    if (current_vuser.blank?) == true
	   redirect_to '/'
	   return
	end
    
	@user = current_vuser
  end
end
