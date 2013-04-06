Octapass::Application.routes.draw do

  resources :posts, only: :new

  root to:"posts#new"
end
