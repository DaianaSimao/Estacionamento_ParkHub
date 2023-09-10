# app/controllers/tickets_controller.rb
class TicketsController < ApplicationController
  before_action :authenticate_user
  layout 'ticket_layout'

  def authenticate_user
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "Você precisa fazer login para acessar esta página."
    end
  end

  def show
    @checkin = Checkin.find(params[:id])
  end

  def gerar_ticket_entrada
    @checkin = Checkin.find(params[:id])
  end

  def gerar_ticket_saida
    @checkin = Checkin.find(params[:id])
    @valor_cobrado = calcular_valor_cobrado(@checkin)
  end

  def calcular_valor_cobrado(checkin)
    hora_entrada = checkin.created_at
    hora_saida = checkin.updated_at
  
    diferenca_segundos = hora_saida - hora_entrada
  
    minutos_permanencia_total = (diferenca_segundos / 1.minute).ceil
    taxa_horaria = checkin.preco.preco_hora / 60
  
    valor_total = minutos_permanencia_total * taxa_horaria
    valor_total
  end
  
  
end

