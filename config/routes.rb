Octapass::Application.routes.draw do

  resources :blogs do
    member do
      get :deploy
      get :select
    end
  end

  resources :posts

  root to:"posts#index"
end
