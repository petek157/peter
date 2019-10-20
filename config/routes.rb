Rails.application.routes.draw do

  root 'home#index'

  get 'admin', :to => 'access#menu'
  get 'access/menu'
  get 'access/login'
  post 'access/attempt_login'
  get 'access/logout'

  get 'res', :to => 'home#resume'
  get 'details', :to => 'home#detail'
  get 'contact', :to => 'home#contact'
  post 'donate', :to => 'home#donate'

  get 'home/index'
  get 'home/resume'
  get 'home/resume/print', :to => 'home#print'
  get 'home/detail'

  resources :job_applications do
    member do
      get :delete
    end
  end

  resources :projects do
    member do
      get :delete
    end
  end

  resources :certificates do
    member do
      get :delete
    end
  end

  resources :resumes do
    member do
      get :delete
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
