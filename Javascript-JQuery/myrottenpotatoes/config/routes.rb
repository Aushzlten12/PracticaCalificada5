Myrottenpotatoes::Application.routes.draw do
  #resources :movies
  resources :movies do
  resources :reviews
end
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/login', to: 'sessions#new'
  post 'logout' => 'sessions#destroy'
  root :to => redirect('/movies')
end
