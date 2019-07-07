Rails.application.routes.draw do

  root "home#home1"
  get "phases/phase1"
  get "phases/phase2"
  get "phases/phase3"
  get 'home/about'
  get 'home/contact'
  get 'home/index'


  get 'user_profiles/temporary_staff'
  get 'user_profiles/scholars'
  get 'user_profiles/others'

  patch "/generate/sticker/:id", :action=>"sticker",:controller =>"check",:as =>"sticker_number"
  patch "/generate/remark/:id", :action=>"remark",:controller=>"check", :as =>"remark"

  get  "pstaffs/showuser/:id" , :action=>"showuser", :controller=>"pstaffs", :as=>"show"
  resources :pstaffs
  resources :user_profiles

  devise_scope :user do
  	delete 'sign_out', to: 'devise/sessions#new'
  end

  devise_for :users, controllers: { registrations: "registrations" }


  resources :users


  get "check/phase1"
  get "check/phase2"
  get "check/phase3"
  get  "check/show_user_form/:id" , :action=>"show_user_form", :controller=>"check", :as=>"show_user"
  post "request/approve/:id" , :action=>"approve",:controller=>"check",:as=>"approve"  
  post "request/disapprove/:id" , :action=>"disapprove",:controller=>"check",:as=>"disapprove"  


  get :approve_mail, to: 'notification#approve_mail', as: :approve_mail
  get :recive_mail, to: 'notify#recive_mail', as: :recive_mail
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
