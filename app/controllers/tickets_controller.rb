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
    @valor_cobrado = TicketService.calcular_valor_cobrado(@checkin)
  end
  
  
end

