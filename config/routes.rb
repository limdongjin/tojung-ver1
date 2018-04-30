Rails.application.routes.draw do

   
  
  
  get 'search_form' => 'propose#search_form' 
  get 'search' => 'propose#search'

  get 'community/index'

  post 'community/new'

  post 'community/create/:id' => 'community#create'
  post 'api/community/:id' => 'community#apidetail'
  get 'community/edit'

  get 'community/:id' => 'community#detail'

  get 'community/update'
  post 'communities/:propose_id' => 'community#index' 
  get 'community/cheart/:id' => 'community#cheart', as: "cheart"
  post 'community/:id/post' => 'community#crepost', as: "cpost"
  get 'community/pheart'

 post 'vote/create' => 'vote#create'

   get 'regist/new'

  post 'regist/create'

  post 'candidate/create/:propose_id' => 'candidate#create'

  get 'candidate/new/:propose_id' => 'candidate#new'

  get 'candidate/detail'

  # 약정
  get 'contract/:id' => 'contract#share'
  get 'contract/new/:propose_id' => 'contract#new'


  post 'contract/create/:propose_id' => 'contract#create'
  
  # get 'contract/delete'

  # 청원
  # get 'propose/index'

  get 'propose/new'

  post 'propose/create'

  get 'propose/edit/:id' => 'propose#edit'

  post 'propose/update/:id' => 'propose#update'

  # get 'propose/delete'

  get 'propose/:id' => 'propose#detail'
  # post 'product/:product_id/comments/create' => 'comments#create'

  # get 'comments/delete/:id' => 'comments#destroy'

  #Rails.application.routes.draw do
  #get 'community/index'

  #get 'community/new'

  #get 'community/create'

  #get 'community/edit'

  # get 'community/update'

  # get 'community/cheart'

  #get 'community/pheart'

  #get 'comment/index'

  #get 'comment/new'

  #get 'comment/create'

  #get 'comment/edit'

  #get 'comment/update'

  #get 'vote/index'

  #get 'vote/new'

  #get 'vote/create'

  #get 'regist/index'

  #get 'regist/new'

  #get 'regist/create'

  #get 'candidate/index'

  #get 'candidate/create'

  #get 'candidate/new'

  #get 'candidate/delete'

  #get 'candidate/update'

  #get 'candidate/edit'

  #get 'candidate/detail'

  #get 'contract/index'

  #get 'contract/new'

  #get 'contract/edit'

  #get 'contract/update'

  #get 'contract/create'

  #get 'contract/delete'

  #get 'propose/index'

  #get 'propose/new'

  #get 'propose/create'

  #get 'propose/edit'

  #get 'propose/update'

  #get 'propose/delete'

  # get 'comments/create'

  # get 'comments/destroy'

    devise_for :vusers, controllers: {
      sessions: 'vuser/sessions',
      registrations: 'vuser/registrations',
	  omniauth_callbacks: 'vuser/omniauth_callbacks'
    }
   #end
  # post 'product/buyok' => 'product#buyok'
  # post 'product/buy/:product_id' => 'product#buy'
  # get 'product/cart_list' => 'product#cart_list'
  # get 'product/list/:page_id' => 'product#list'

  # get 'product/detail/:product_id'=> 'product#detail'

  root 'home#index'

  get '/mypage' => 'home#mypage'
  get 'home/index'

  get 'home/about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
