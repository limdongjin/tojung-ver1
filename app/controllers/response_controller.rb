class ResponseController < ApplicationController
  def index
    #if current_vuser != nil and current_vuser.email == "admin@2jung.com"
  end

  def agree
    key = params[:key]
    print("key\n")

    print(key)
    print(key.class)
    @key = key
    @pr = ""

    if PersonResponse.where(agree_hash: key).count != 0
      pr = PersonResponse.where(agree_hash: key)[0]
      print(pr)
      pr.response_type = "찬성"
      pr.save

      @pr = pr.id
    else
      redirect_to '/'
    end

    print("\nnono")
  end

  def disagree
    key = params[:key]
    @key = key
    @pr = ""

    if PersonResponse.where(disagree_hash: key).count != 0
      pr = PersonResponse.where(disagree_hash: key)[0]
      pr.response_type = "반대"
      pr.save

      @pr = pr.id
      return
    else
      redirect_to '/'
      return
    end
  end
  def discuss
    if params[:type] == "agree"
      if PersonResponse.where(agree_hash: params[:key]).count != 0
        p = PersonResponse.where(agree_hash: params[:key])[0]
        p.response_text = params[:content]
        p.save

        @c = p.response_text
        @t = params
        return
      end
    elsif params[:type] == "disagee"
      if PersonResponse.where(disagree_hash: params[:key]).count != 0
        p = PersonResponse.where(disagree_hash: params[:key])[0]
        p.response_text = params[:content]
        p.save
        @c = p.response_text
        @t = params
        return
      end
    end
    @c = "노노"
    @t = "놉 ㅠㅠ"

  end

end
