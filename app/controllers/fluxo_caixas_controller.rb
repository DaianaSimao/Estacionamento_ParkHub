class FluxoCaixasController < ApplicationController
  before_action :authenticate_user!

  def authenticate_user
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "Você precisa fazer login para acessar esta página."
    end
  end

  def index   
    @fluxo_caixas = FluxoCaixa.all
    @entrada = FluxoCaixa.where(tipo: 'Entrada').sum(:valor)
    @saida = FluxoCaixa.where(tipo: 'Saida').sum(:valor)
    @total = @entrada - @saida

    if params[:descricao].present?
      @fluxo_caixas = @fluxo_caixas.where("descricao ILIKE ?", "%#{params[:descricao]}%")
    end

    if params[:tipo].present?
      @fluxo_caixas = @fluxo_caixas.where("tipo ILIKE ?", "%#{params[:tipo]}%" )
    end

    if params[:categoria].present?
      @fluxo_caixas = @fluxo_caixas.where("categoria ILIKE ?", "%#{params[:categoria]}%")
    end

    if params[:forma_pagamento].present?
      @fluxo_caixas = @fluxo_caixas.where("forma_pagamento ILIKE ?", "%#{params[:forma_pagamento]}%" )
    end
    
    if params[:valor].present?
    @fluxo_caixas = @fluxo_caixas.where("valor ILIKE ?", "%#{params[:valor]}%")
    end

    if params[:status].present?
      @fluxo_caixas = @fluxo_caixas.where("status ILIKE ?", "%#{params[:status]}%")
    end

    if params[:min].present? and params[:max].present?
      min = (params[:min] + " 00:00").to_datetime + 3.hours
      max = (params[:max] + " 24:00").to_datetime + 3.hours

      @fluxo_caixas = @fluxo_caixas.criado_entre(min,max)
    end
  end

  def show
    @fluxo_caixa = FluxoCaixa.find(params[:id])
  end
end