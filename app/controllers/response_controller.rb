class ResponseController < ApplicationController
  def agree
    key = params[:key]
    if !(PersonResponse.where(agree_hash: key).count.zero)?
      pr = PersonResponse.where(agree_hash: key)[0]
      pr.response_type = '찬성'
      pr.save
      return
    end
  end

  def disagree
    if !(PersonResponse.where(disagree_hash: key).count.zero)?
      pr = PersonResponse.where(disagree_hash: key)[0]
      pr.response_type = '반대'
      pr.save
    end
  end

end
