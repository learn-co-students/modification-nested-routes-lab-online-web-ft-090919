Rails.application.routes.draw do
  resources :artists do
    resources :songs, only: [:new, :edit, :index, :show]
  end
  resources :songs

end