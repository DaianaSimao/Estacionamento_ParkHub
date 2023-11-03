class EntradasFinanceirasController < ApplicationController
  before_action :set_entradas_financeira, only: %i[ show edit update destroy ]

  # GET /entradas_financeiras or /entradas_financeiras.json
  def index
    @entradas_financeiras = EntradasFinanceira.all
  end

  # GET /entradas_financeiras/1 or /entradas_financeiras/1.json
  def show
  end

  # GET /entradas_financeiras/new
  def new
    @entradas_financeira = EntradasFinanceira.new
  end

  # GET /entradas_financeiras/1/edit
  def edit
  end

  # POST /entradas_financeiras or /entradas_financeiras.json
  def create
    @entradas_financeira = EntradasFinanceira.new(entradas_financeira_params)

    respond_to do |format|
      if @entradas_financeira.save
        format.html { redirect_to entradas_financeira_url(@entradas_financeira), notice: "Entradas financeira was successfully created." }
        format.json { render :show, status: :created, location: @entradas_financeira }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entradas_financeira.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entradas_financeiras/1 or /entradas_financeiras/1.json
  def update
    respond_to do |format|
      if @entradas_financeira.update(entradas_financeira_params)
        format.html { redirect_to entradas_financeira_url(@entradas_financeira), notice: "Entradas financeira was successfully updated." }
        format.json { render :show, status: :ok, location: @entradas_financeira }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entradas_financeira.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entradas_financeiras/1 or /entradas_financeiras/1.json
  def destroy
    @entradas_financeira.destroy

    respond_to do |format|
      format.html { redirect_to entradas_financeiras_url, notice: "Entradas financeira was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entradas_financeira
      @entradas_financeira = EntradasFinanceira.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entradas_financeira_params
      params.require(:entradas_financeira).permit(:tipo, :descricao, :total, :forma_pagamento, :responsavel, :obs)
    end
end
