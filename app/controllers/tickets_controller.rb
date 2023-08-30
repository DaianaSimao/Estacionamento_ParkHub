# app/controllers/tickets_controller.rb
class TicketsController < ApplicationController
  before_action :authenticate_user
  layout 'ticket_layout'

  def authenticate_user
    unless user_signed_in?
      redirect_to login_path, alert: "Você precisa fazer login para acessar esta página."
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
    hora_atual = Time.now
    diferenca_segundos = hora_atual - checkin.updated_at

    horas_permanencia = diferenca_segundos / 1.hour
    taxa_horaria = @checkin.preco.preco_hora
    valor_total = horas_permanencia * taxa_horaria
    valor_total.round(2)
  end
end

