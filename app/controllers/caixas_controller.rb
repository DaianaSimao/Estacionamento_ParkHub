class CaixasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_caixa, only: %i[ show edit update destroy ]

  # GET /caixas or caixas.json
  def index
    @caixas = Caixa.all
    if params[:min].present? and params[:max].present?
      min = (params[:min] + " 00:00").to_datetime + 3.hours
      max = (params[:max] + " 24:00").to_datetime + 3.hours
      @caixas  = @caixas.criado_entre(min,max)
    end

    if params[:id].present?
      @caixas = @caixas.where(id: params[:id])
    end

    if params[:forma_pagamento].present?
      @caixas = @caixas.where(forma_pagamento: params[:forma_pagamento])
    end
    
  end

  def search
    @search = params[:search]
    @caixas = Caixa.where("CAST(id AS TEXT) LIKE ?", "%#{@search}%")
    render :index
  end

  # GET /caixas/1 or /caixas/1.json
  def show
  end

  # GET /caixas/new
  def new
    @checkin = Checkin.find(params[:checkin_id])
    @caixa = Caixa.new
    @caixa.checkin_id = @checkin.id
    if @checkin.present? && @checkin.saida.present? && @checkin.entrada.present?
      duracao_em_segundos = (@checkin.saida - @checkin.entrada).to_i

      horas = duracao_em_segundos / 3600
      minutos = (duracao_em_segundos % 3600) / 60
      segundos = duracao_em_segundos % 60
      minutos_permanencia_total = (duracao_em_segundos / 1.minute).ceil

      @caixa.tempo_estadia = "#{horas}:#{minutos}"
      if minutos_permanencia_total < 60
        @caixa.total = @checkin.preco.preco_hora
      else
        valor_total = TicketService.calcular_valor_cobrado(@checkin)
        @caixa.total = valor_total
      end
      
    else
      @caixa.tempo_estadia = "Tempo não disponível"
    end
  end

  # GET /caixas/1/edit
  def edit
  end

  # POST /caixas or /caixas.json

  def create
    @caixa = Caixa.new(caixa_params)

    respond_to do |format|
      if @caixa.save
        format.html { redirect_to caixas_url, notice: "caixa efetudado com sucesso." }
        format.json { render :show, status: :created, location: @caixa }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @caixa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /caixas/1 or /caixas/1.json
  def update
    @checkin = Checkin.find(params[:checkin_id])
    respond_to do |format|
      if @caixa.update(caixa_params)
        format.html { redirect_to caixa_url(@caixa), notice: "caixa modificado com sucesso." }
        format.json { render :show, status: :ok, location: @caixa }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @caixa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /caixas/1 or /caixas/1.json
  def destroy
    @caixa.destroy

    respond_to do |format|
      format.html { redirect_to caixas_url, notice: "caixa apagado com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_caixa
      @caixa = Caixa.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def caixa_params
      params.require(:caixa).permit(:checkin_id, :forma_pagamento, :valor, :troco, :data_pagamento, :tempo_estadia, :status, :total)
    end
end
