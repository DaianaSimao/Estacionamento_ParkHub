class CheckinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_checkin, only: [:show, :edit, :update, :destroy, :update_status]

  def authenticate_user
    unless user_signed_in?
      redirect_to new_user_session_path, alert: "Você precisa fazer login para acessar esta página."
    end
  end
  
  def index
    @checkins = Checkin.all

    if params[:min].present? and params[:max].present?
      min = (params[:min] + " 00:00").to_datetime + 3.hours
      max = (params[:max] + " 24:00").to_datetime + 3.hours
      @checkins  = @checkins.criado_entre(min,max)
    end
    if params[:veiculo_placa].present?
      @checkins = Checkin.where("veiculo_placa ILIKE ?", "%#{params[:veiculo_placa]}%")
    end

    @checkins = @checkins.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    preco = @checkin.calcular_preco
  end

  def new
    @checkin = Checkin.new
  end

  def create
    @checkin = Checkin.new(checkin_params)
    @checkin.numero_ticket = SecureRandom.hex(10)
    respond_to do |format|
      if @checkin.save
        format.html { redirect_to checkins_url, notice: "Check-in criado com sucesso." }
        format.json { render :show, status: :created, location: @checkin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    @checkin.status = params[:status] == 'Ocupada' ? true : false

    if @checkin.update(checkin_params)
      redirect_to checkins_path, notice: 'Check-in atualizado com sucesso.'
    else
      render :edit
    end
  end

  # PATCH /checkins/:id/update_status
  def update_status
    if @checkin.update(checkin_params)
      render json: { message: 'Estadia finalizada com sucesso.', redirect_to: new_caixa_path(checkin_id: @checkin.id) }, status: :ok
    else
      render json: { errors: @checkin.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @checkin.destroy
    redirect_to checkins_path, notice: 'Check-in excluído com sucesso.'
  end

  private

  def set_checkin
    @checkin = Checkin.find(params[:id])
  end

  def checkin_params
    params.require(:checkin).permit(:veiculo_placa, :status, :preco_id, :vaga_id, :numero_ticket, :em_permanencia)
  end
end
