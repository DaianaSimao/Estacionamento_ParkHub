Rails.application.routes.draw do
  get 'relatorios/index'
  resources :fluxo_caixas
  resources :create_table_fluxo_caixas
  
  root "inicio#index"

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :checkins do 
    resources :caixas, only: [:new, :create]
  end
  
  resources :despesas
  resources :caixas
  resources :vagas
  resources :veiculos
  resources :precos
  
  get 'relatorios/index', as: 'relatorios', to: 'relatorios#index'
  get 'tickets/gerar_ticket_entrada/:id', as: 'gerar_ticket_entrada', to: 'tickets#gerar_ticket_entrada'
  get 'tickets/gerar_ticket_saida/:id', as: 'gerar_ticket_saida', to: 'tickets#gerar_ticket_saida'
  get 'inicio/index'
end
