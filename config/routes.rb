Rails.application.routes.draw do
  post 'product/:product_id/comments/create' => 'comments#create'

  get 'comments/delete/:id' => 'comments#destroy'

  #devise_for :vusers
  Rails.application.routes.draw do     
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
  # post 'product/addcart' => 'product#addcart'
  get 'product/cart_list' => 'product#cart_list'  
  get 'product/list/:page_id' => 'product#list'

  get 'product/detail/:product_id'=> 'product#detail'

  root 'home#index'

  get '/mypage' => 'home#mypage'
  get 'home/index'

  get 'home/about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
