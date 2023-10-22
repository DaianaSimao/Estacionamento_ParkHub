# app/controllers/tickets_controller.rb
class TicketsController < ApplicationController
  before_action :authenticate_user
  layout 'ticket_layout'
  before_action :set_checkin, only: [:show, :gerar_ticket_saida]

  def authenticate_user
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "Você precisa fazer login para acessar esta página."
    end
  end

  def show

  end

  def gerar_ticket_entrada
  end

  def gerar_ticket_saida
    @valor_total = TicketService.calcular_valor_cobrado(@checkin)
  end
  
  def set_checkin
    @checkin = Checkin.find(params[:id])
  end
end

