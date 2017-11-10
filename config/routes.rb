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
    resources :teams, only: [:new, :create]
  end
  
  resources :teams do
    resources :assessments, only: :index
  end
  
  resources :users do
    member do
      get :start_assessment, action: :start_assessment
    end
  end

  root 'home#index'
end
