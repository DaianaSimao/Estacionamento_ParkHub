class CaixasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_caixa, only: %i[ show edit update destroy ]

  # GET /caixas or caixas.json

  def calcular_pagamento
    valor = params[:valor].to_f
    pagamento = params[:forma_pagamento]
    total = params[:total].to_f
    troco = 0
    if forma_pagamento == '1'
      troco = valor > total ? (valor - total).round(2) : 0
      total = valor
    end
    render json: { total: total.round(2), troco: troco.round(2), valor: valor.round(2), preco_hora: total.round(2) }
  end
  
  def index
    @caixas = Caixa.all.order(created_at: :desc)
    if params[:min].present? and params[:max].present?
      min = (params[:min] + " 00:00").to_datetime + 3.hours
      max = (params[:max] + " 24:00").to_datetime + 3.hours
      @caixas  = @caixas.criado_entre(min,max)
    end

    if params[:id].present?
      @caixas = @caixas.where(id: params[:id])
    end

    if params[:forma_pagamento].present?
      @caixas = @caixas.where('forma_pagamento ILIKE ?', "%#{params[:forma_pagamento]}%")
    end
    @caixas = @caixas.order(created_at: :desc).page(params[:page]).per(10)
  end

  # GET /caixas/1 or /caixas/1.json
  def show
  end

  # GET /caixas/new
  def new
    @caixa = Caixa.new
    @caixa.build_pagamento
    @caixa.checkin_id = params[:checkin_id]
    if @caixa.checkin.preco.tipo != "Diaria"
      if @caixa.checkin.present? && @caixa.checkin.saida.present? && @caixa.checkin.entrada.present?
        duracao_em_segundos = (@caixa.checkin.saida - @caixa.checkin.entrada).to_i

        horas = duracao_em_segundos / 3600
        minutos = (duracao_em_segundos % 3600) / 60
        segundos = duracao_em_segundos % 60
        minutos_permanencia_total = (duracao_em_segundos / 1.minute).ceil

        @caixa.tempo_estadia = "#{horas}:#{minutos}"
        if minutos_permanencia_total < 60
          @total = @caixa.checkin.preco.preco_hora
        else
          @valor_total = TicketService.calcular_valor_cobrado(@caixa.checkin)
          @total = @valor_total
        end
        
      else
        @caixa.tempo_estadia = "Tempo não disponível"
      end
    else
      @valor = @caixa.checkin.preco.preco_hora
      @total = @valor
      @caixa.tempo_estadia = "1 dia"
    end
  end

  # GET /caixas/1/edit
  def edit
  end

  # POST /caixas or /caixas.json

  def create
    @caixa = Caixa.new(caixa_params)
    @caixa.descricao = "Caixa"
    @caixa.checkin_id = params[:caixa][:checkin_id]
    @caixa.pagamento.forma_pagamento_id = params[:caixa][:forma_pagamento_id]
    respond_to do |format|
      if @caixa.save
        format.html { redirect_to caixas_url, notice: "Pagamento efetudado com sucesso." }
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
        format.html { redirect_to caixa_url(@caixa), notice: "Pagamento modificado com sucesso." }
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
      format.html { redirect_to caixas_url, notice: "Pagamento apagado com sucesso." }
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
      params.require(:caixa).permit(:tempo_estadia, :status,:checkin_id, :logado, :pagamento_attributes => [:id, :forma_pagamento_id, :troco, :valor, :total, :_destroy])
    end
end
