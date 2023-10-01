class PagamentosController < ApplicationController
  before_action :set_pagamento, only: %i[ show edit update destroy ]

  # GET /pagamentos or /pagamentos.json
  def index
    @pagamentos = Pagamento.all
  end

  # GET /pagamentos/1 or /pagamentos/1.json
  def show
  end

  # GET /pagamentos/new
  def new
    @checkin = Checkin.find(params[:checkin_id])
    @pagamento = Pagamento.new
    @pagamento.checkin_id = @checkin.id
    if @checkin.present? && @checkin.saida.present? && @checkin.entrada.present?
      duracao_em_segundos = (@checkin.saida - @checkin.entrada).to_i

      horas = duracao_em_segundos / 3600
      minutos = (duracao_em_segundos % 3600) / 60
      segundos = duracao_em_segundos % 60
      minutos_permanencia_total = (duracao_em_segundos / 1.minute).ceil

      @pagamento.tempo_estadia = "#{horas} H #{minutos} m #{segundos} s"
      if minutos_permanencia_total < 60
        @pagamento.valor = @checkin.preco.preco_hora
      else
        valor_total = TicketService.calcular_valor_cobrado(@checkin)
        @pagamento.valor = valor_total
      end
      
    else
      @pagamento.tempo_estadia = "Tempo não disponível"
    end
  end

  # GET /pagamentos/1/edit
  def edit
  end

  # POST /pagamentos or /pagamentos.json

  def create
    @pagamento = Pagamento.new(pagamento_params)

    respond_to do |format|
      if @pagamento.save
        format.html { redirect_to pagamentos_url, notice: "Pagamento was successfully created." }
        format.json { render :show, status: :created, location: @pagamento }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pagamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pagamentos/1 or /pagamentos/1.json
  def update
    respond_to do |format|
      if @pagamento.update(pagamento_params)
        format.html { redirect_to pagamento_url(@pagamento), notice: "Pagamento was successfully updated." }
        format.json { render :show, status: :ok, location: @pagamento }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pagamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pagamentos/1 or /pagamentos/1.json
  def destroy
    @pagamento.destroy

    respond_to do |format|
      format.html { redirect_to pagamentos_url, notice: "Pagamento was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pagamento
      @pagamento = Pagamento.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pagamento_params
      params.require(:pagamento).permit(:checkin_id, :forma_pagamento, :valor, :troco, :data_pagamento, :tempo_estadia, :status)
    end
end
