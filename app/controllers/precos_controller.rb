class PrecosController < ApplicationController
  before_action :authenticate_user
  before_action :set_preco, only: %i[ show edit update destroy ]

  def authenticate_user
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "Você precisa fazer login para acessar esta página."
    end
  end

  def index
    @precos = Preco.all
  end

  def show
  end

  # GET /precos/new
  def new
    @preco = Preco.new
  end

  # GET /precos/1/edit
  def edit
  end

  def create
    @preco = Preco.new(preco_params)

    respond_to do |format|
      if @preco.save
        format.html { redirect_to precos_path, notice: "Preço criado com sucesso." }
        format.json { render :show, status: :created, location: @preco }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @preco.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @preco.update(preco_params)
        format.html { redirect_to precos_path(@precos), notice: "Preço Atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @preco }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @preco.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @preco.destroy

    respond_to do |format|
      format.html { redirect_to precos_path, notice: "Preço excluido com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preco
      @preco = Preco.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def preco_params
      params.require(:preco).permit( :preco_hora, :tipo)
    end
end
