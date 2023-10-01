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
    @valor_total = 0
    if @checkin.present? && @checkin.saida.present? && @checkin.entrada.present?
      duracao_em_segundos = (@checkin.saida - @checkin.entrada).to_i

      horas = duracao_em_segundos / 3600
      minutos = (duracao_em_segundos % 3600) / 60
      segundos = duracao_em_segundos % 60
      minutos_permanencia_total = (duracao_em_segundos / 1.minute).ceil

      if minutos_permanencia_total < 60
        @valor_total = @checkin.preco.preco_hora
      else
        @valor_total = TicketService.calcular_valor_cobrado(@checkin)
      end
    end
    @valor_total = @valor_total.round(2)
  end
  
  
end

