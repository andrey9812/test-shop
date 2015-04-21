Rails.application.routes.draw do
  devise_for :users

  root 'home#show'

  resource :cart, :only => [:show, :update, :destroy], :controller => 'cart' do
    get 'full_price' => 'cart#full_price'
    post 'add' => 'cart#add'
  end

  resources :invoices, :only => [:index, :create]
  resources :transactions, :only => [:create]
end
