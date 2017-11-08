Rails.application.routes.draw do
  get 'home/index'
  get 'home/about'

  get 'assess/step1'
  get 'assess/step2'
  get 'assess/step3'
  get 'assess/step4'
  get 'assess/step5'
  get 'assess/step6'
  
  resources :assessments do
    collection do
      get :areas, action: :areas
    end
    member do
      get :share, action: :share
    end
  end
  
  resources :teams

  root 'home#index'
end
