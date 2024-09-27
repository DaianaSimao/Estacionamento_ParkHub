class FormaPagamentosController < ApplicationController
  before_action :set_forma_pagamento, only: [:show, :edit, :update, :destroy]

  # GET /forma_pagamentos
  def index
    @forma_pagamentos = FormaPagamento.all
  end

  # GET /forma_pagamentos/1
  def show
  end

  # GET /forma_pagamentos/new
  def new
    @forma_pagamento = FormaPagamento.new
  end

  # GET /forma_pagamentos/1/edit
  def edit
  end

  # POST /forma_pagamentos
  def create
    @forma_pagamento = FormaPagamento.new(forma_pagamento_params)

    if @forma_pagamento.save
      redirect_to @forma_pagamento, notice: 'Forma de pagamento criada com sucesso.'
    else
      render :new
    end
  end

  # PATCH/PUT /forma_pagamentos/1
  def update
    if @forma_pagamento.update(forma_pagamento_params)
      redirect_to @forma_pagamento, notice: 'Forma de pagamento atualizada com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /forma_pagamentos/1
  def destroy
    @forma_pagamento.destroy
    redirect_to forma_pagamentos_url, notice: 'Forma de pagamento excluída com sucesso.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forma_pagamento
      @forma_pagamento = FormaPagamento.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def forma_pagamento_params
      params.require(:forma_pagamento).permit(:nome, :descricao)
    end
end