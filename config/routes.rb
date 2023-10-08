Rails.application.routes.draw do
  

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :checkins do 
    collection do
      get 'search'
    end
    resources :pagamentos, only: [:new, :create]
  end
  resources :pagamentos do
    collection do
      get 'search'
    end
  end
  resources :vagas
  resources :veiculos
  resources :precos
  
  get 'tickets/gerar_ticket_entrada/:id', as: 'gerar_ticket_entrada', to: 'tickets#gerar_ticket_entrada'
  get 'tickets/gerar_ticket_saida/:id', as: 'gerar_ticket_saida', to: 'tickets#gerar_ticket_saida'

  get 'inicio/index'
  root "inicio#index"

end
