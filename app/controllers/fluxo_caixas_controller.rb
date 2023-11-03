class FluxoCaixasController < ApplicationController
  before_action :authenticate_user!
  
  def authenticate_user
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "Você precisa fazer login para acessar esta página."
    end
  end
  
  def index   
    if params[:min].present? and params[:max].present?
      @min = (params[:min] + " 00:00").to_datetime + 3.hours
      @max = (params[:max] + " 24:00").to_datetime + 3.hours
    else 
      @min = Date.today.beginning_of_day
      @max = Date.today.end_of_day
    end
    
    @fluxo_caixas = FluxoCaixa.criado_entre(@min,@max)
    @entrada = @fluxo_caixas.where(tipo: 'Entrada').sum(:valor)
    @saida = @fluxo_caixas.where(tipo: 'Saida').sum(:valor)
    @total = @entrada. - @saida
    @total_semana = @fluxo_caixas.where("created_at >= ? AND created_at <= ?", (@max - 1.week).beginning_of_day , @max.end_of_day).sum(:valor)
    @total_mes = @fluxo_caixas.where("created_at >= ? AND created_at <= ?",(@max - 1.months).beginning_of_day , @max.end_of_day ).sum(:valor)

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

   
  end

  def show
    @fluxo_caixa = FluxoCaixa.find(params[:id])
  end
end