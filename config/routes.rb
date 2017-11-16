Rails.application.routes.draw do
  get 'home/index'
  get 'home/privacy'
  get 'home/finish'

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
