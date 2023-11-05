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
    # Metodo que traz a data da semana
    dia_da_semana = @min.wday
    @inicio_semana = @min - dia_da_semana
    @final_semana = @inicio_semana + 6

    # Metodo que traz a data do mês anterior
    @inicio_mes_anterior = @min.prev_month.beginning_of_month
    @fim_mes_anterior = @min.prev_month.end_of_month

    @inicio_mes = Date.new(@min.year, @min.month, 1)
    @fim_mes = Date.new(@min.year, @min.month, -1)
    
    @fluxo_caixas = FluxoCaixa.criado_entre(@min,@max)
    @entrada = @fluxo_caixas.where(tipo: 'Entrada').sum(:valor)
    @saida = @fluxo_caixas.where(tipo: 'Saida').sum(:valor)
    @total = @entrada. - @saida
    @entrada_semana = FluxoCaixa.where("created_at >= ? AND created_at <= ? AND tipo = ?",@inicio_semana.beginning_of_day , @final_semana.end_of_day, 'Entrada' ).sum(:valor)
    @saida_semana = FluxoCaixa.where("created_at >= ? AND created_at <= ? AND tipo = ?",@inicio_semana.beginning_of_day , @final_semana.end_of_day, 'Saida' ).sum(:valor)
    @total_semana = FluxoCaixa.where("created_at >= ? AND created_at <= ?",@inicio_semana.beginning_of_day , @final_semana.end_of_day ).sum(:valor)
    @entrada_mes = FluxoCaixa.where("created_at >= ? AND created_at <= ? AND tipo = ?",@inicio_mes.beginning_of_day , @fim_mes.end_of_day, 'Entrada' ).sum(:valor)
    @saida_mes = FluxoCaixa.where("created_at >= ? AND created_at <= ? AND tipo = ?",@inicio_mes.beginning_of_day , @fim_mes.end_of_day, 'Saida' ).sum(:valor)
    @total_mes =FluxoCaixa.where("created_at >= ? AND created_at <= ?",@inicio_mes.beginning_of_day , @fim_mes.end_of_day ).sum(:valor)
    @entrada_mes_anterior = FluxoCaixa.where("created_at >= ? AND created_at <= ? AND tipo = ?",@inicio_mes_anterior.beginning_of_day , @fim_mes_anterior.end_of_day, 'Entrada' ).sum(:valor)
    @saida_mes_anterior = FluxoCaixa.where("created_at >= ? AND created_at <= ? AND tipo = ?",@inicio_mes_anterior.beginning_of_day , @fim_mes_anterior.end_of_day, 'Saida' ).sum(:valor)
    @total_mes_anterior = FluxoCaixa.where("created_at >= ? AND created_at <= ?",@inicio_mes_anterior.beginning_of_day , @fim_mes_anterior.end_of_day ).sum(:valor)

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

    @fluxo_caixas = @fluxo_caixas.order(created_at: :desc).page(params[:page]).per(10)

  end

  def show
    @fluxo_caixa = FluxoCaixa.find(params[:id])
  end
end