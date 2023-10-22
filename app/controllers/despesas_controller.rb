class DespesasController < ApplicationController
  before_action :set_despesa, only: %i[ show edit update destroy ]

  # GET /despesas or /despesas.json
  def index
    @despesas = Despesa.all
    if params[:descricao].present?
      @despesas = @despesas.where("descricao ILIKE ?", "%#{params[:descricao]}%")
    end
  end

  # GET /despesas/1 or /despesas/1.json
  def show
  end

  # GET /despesas/new
  def new
    @despesa = Despesa.new
  end

  # GET /despesas/1/edit
  def edit
  end

  # POST /despesas or /despesas.json
  def create
    @despesa = Despesa.new(despesa_params)

    respond_to do |format|
      if @despesa.save
        format.html { redirect_to despesas_url, notice: "Despesa criada com sucesso." }
        format.json { render :show, status: :created, location: @despesa }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @despesa.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /despesas/1 or /despesas/1.json
  def update
    respond_to do |format|
      if @despesa.update(despesa_params)
        format.html { redirect_to despesa_url(@despesa), notice: "Despesa editada com sucesso." }
        format.json { render :show, status: :ok, location: @despesa }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @despesa.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /despesas/1 or /despesas/1.json
  def destroy
    @despesa.destroy

    respond_to do |format|
      format.html { redirect_to despesas_url, notice: "Despesa apagada com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_despesa
      @despesa = Despesa.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def despesa_params
      params.require(:despesa).permit(:descricao, :valor, :categoria, :forma_pagamento, :status, :data_pagamento, :data_vencimento)
    end
end
