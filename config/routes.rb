Rails.application.routes.draw do
  
  # 후보자 등록	
  get 'candidate/index'

  post 'candidate/create/:propose_id' => 'candidate#create'

  get 'candidate/new/:propose_id' => 'candidate#new'

  get 'candidate/delete'

  get 'candidate/update'

  get 'candidate/edit'

  get 'candidate/detail'

  # 약정 	
  get 'contract/index'

  get 'contract/new'

  get 'contract/edit'

  get 'contract/update'

  get 'contract/create'

  get 'contract/delete'

  # 청원
  get 'propose/index'

  get 'propose/new'

  post 'propose/create'

  get 'propose/edit'

  get 'propose/update'

  get 'propose/delete'

  get 'propose/:id' => 'propose#detail'
  post 'product/:product_id/comments/create' => 'comments#create'

  get 'comments/delete/:id' => 'comments#destroy'

  Rails.application.routes.draw do     
  get 'candidate/index'

  get 'candidate/create'

  get 'candidate/new'

  get 'candidate/delete'

  get 'candidate/update'

  get 'candidate/edit'

  get 'candidate/detail'

  get 'contract/index'

  get 'contract/new'

  get 'contract/edit'

  get 'contract/update'

  get 'contract/create'

  get 'contract/delete'

  get 'propose/index'

  get 'propose/new'

  get 'propose/create'

  get 'propose/edit'

  get 'propose/update'

  get 'propose/delete'

  get 'comments/create'

  get 'comments/destroy'

    devise_for :vusers, controllers: { 
      sessions: 'vuser/sessions', 
      registrations: 'vuser/registrations',
	  omniauth_callbacks: 'vuser/omniauth_callbacks'
    }                                  
   end                                  
  post 'product/buyok' => 'product#buyok'  
  post 'product/buy/:product_id' => 'product#buy'
  get 'product/cart_list' => 'product#cart_list'  
  get 'product/list/:page_id' => 'product#list'

  get 'product/detail/:product_id'=> 'product#detail'

  root 'home#index'

  get '/mypage' => 'home#mypage'
  get 'home/index'

  get 'home/about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
