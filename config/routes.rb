Rails.application.routes.draw do
  #devise_for :vusers
  Rails.application.routes.draw do     
    devise_for :vusers, controllers: { 
      sessions: 'vusers/sessions', 
      registrations: 'vusers/registrations'  
    }                                  
   end                                  

  get 'product/list/:page_id' => 'product#list'

  get 'product/detail/:product_id'=> 'product#detail'

  root 'home#index'

  get 'home/index'

  get 'home/about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
