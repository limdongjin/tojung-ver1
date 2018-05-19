# noinspection ALL
class ProposeController < ApplicationController
  # GET /propose/:id/email_form/:person_id
  def email_form
    @propose = Vpropose.find(params[:id].to_i)
    @person = Person.find(params[:person_id].to_i)
    @person_res = PersonResponse.where(propose_id: params[:id],
                                       person_id: params[:person_id])[0]
  end

  def email_send
    UserMailer.welcome_email(params[:user_email],
                             params[:person_email],
                             params[:title],
                             params[:content]).deliver_now

    person_res = PersonResponse.where(propose_id: params[:id],
                                      person_id: params[:person_id])[0]

    person_res.send_count = (person_res.send_count.to_i + 1).to_s
    person_res.save

    redirect_to '/propose/' + params[:id]
  end

  # GET /propose/index
  def index
    # 청원 목록 페이지 ( 테스트용 )
    @proposes = Vpropose.all
  end

  # GET /search_form
  def search_form; end

  # GET /search?keyword=과학
  def search
    keyword = params[:keyword]
    redirect_to '/' if keyword.nil?
    wild_keyword = '%' + keyword + '%'
    @proposes = Vpropose.where('title LIKE ?', wild_keyword)
                        .or(Vpropose.where('content LIKE ?', wild_keyword)
    .or(Vpropose.where('bg_category_name LIKE ?', wild_keyword)))
  end

  # GET /propose/:id
  def detail
    # 청원 세부 정보 페이지
    print(request.base_url)
    @base_url = request.base_url
    @propose = Vpropose.find(params[:id].to_i)

    @propose.save

    @writer = Vuser.find(@propose.user_id)

    @result = {}

    @result['propose'] = {}
    @result['propose']['object'] = @propose
    @result['propose']['writer'] = Vuser.find(@propose.user_id)

    if !@result['propose']['object'].image.url.nil?
      print('not nil')
      @result['image'] = @result['propose']['object'].image.url
    else
      print('nil')
      @result['image'] = @result['propose']['object'].default_image
      print(@result['image'])
    end

    # Person.find_by_assos()
    @people = Person.where('shrtnm like ?', "%#{@propose.assos}%")

    @people_res = {}
    @people.each do |person|
      person_response = PersonResponse.where(propose_id: @propose.id, person_id: person.id)
      if person_response.count.zero?
        person_response = PersonResponse.create(name: person.name,
                                                person_id: person.id,
                                                response_type: '무응답',
                                                response_text: '',
                                                send_count: 0,
                                                propose_id: @propose.id,
                                                agree_hash: SecureRandom.base64(50),
                                                disagree_hash: SecureRandom.base64(50)
                                                )
      else
        person_response = person_response[0]
        if person_response.agree_hash == nil
          person_response.agree_hash = SecureRandom.base64(50)
        end
        if person_response.disagree_hash == nil
          person_response.disagree_hash = SecureRandom.base64(50)
        end
      end

      @people_res[person.id] = person_response
      person_response.save
    end
  end

  # GET /propose/new
  def new
    # 청원 생성 페이지
    if current_vuser != Vuser.find_by_email('admin@2jung.com')
      redirect_to '/'
      return
    end

    redirect_to '/', alert: '로그인해야 청원할 수 있습니다.' if current_vuser.nil?
  end

  # GET /propose/edit/:id
  def edit
    if current_vuser.nil?
      redirect_to '/'
      return
    end
    if current_vuser != Vuser.find_by_email('admin@2jung.com')
      redirect_to '/'
      return
    end
    @propose = Vpropose.find(params[:id])
  end

  # POST /propose/create
  def create
    # 청원 생성 액션 및 약정 생성 액션

    if current_vuser.nil?
      redirect_to '/'
      return
    end
    if current_vuser != Vuser.find_by_email('admin@2jung.com')
      redirect_to '/'
      return
    end

    # 청원 생성
    @propose = Vpropose.new

    @propose.title   = params[:propose_title]   # 제목
    @propose.content = params[:propose_content] # 내용
    @propose.assos = params[:assos] # 상임위

    @propose.image   = params[:propose_image]   # 대표사진
    @propose.goods   = params[:goods]           # 굿즈 이미지
    @propose.campaign = params[:campaign]       # 캠페인 이미지

    @propose.campaign_content = params[:campaign_content] # 캠페인 설명
    @propose.bill_link = params[:bill_link] # 법안 링크
    @propose.tumb = params[:tumb] # 텀블벅 링크

    @propose.user_id = current_vuser.id

    @propose.status  = '펀딩진행중'

    @propose.funded_money = 0
    @propose.goal_money = 10_000_000
    @propose.funded_num = 1
    @propose.save

    redirect_to '/propose/' + @propose.id.to_s
  end


  # POST /propose/update/:id
  def update
    if @propose.user_id != current_vuser.id
      redirect_to '/'
      return
    end

    if current_vuser != Vuser.find_by_email('admin@2jung.com')
      redirect_to '/'
      return
    end

    @propose = Vpropose.find(params[:id].to_i)

    @propose.title   = params[:propose_title]   # 제목
    @propose.content = params[:propose_content] # 내용
    @propose.assos = params[:assos] # 상임위

    @propose.image   = params[:propose_image]   # 대표사진
    @propose.goods   = params[:goods]           # 굿즈 이미지
    @propose.campaign = params[:campaign]       # 캠페인 이미지

    @propose.campaign_content = params[:campaign_content] # 캠페인 설명
    @propose.bill_link = params[:bill_link] # 법안 링크
    @propose.tumb = params[:tumb] # 텀블벅 링크

    @propose.save

    redirect_to '/propose/' + @propose.id.to_s
  end

  def delete; end
end
