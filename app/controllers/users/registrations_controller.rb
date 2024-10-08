class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: [:new, :create]
  # Permitir que usuários logados acessem a página de registro
  def new
    @user = User.new # Crie uma nova instância de usuário
    render :new
  end

  def create
    super do |resource|
      if resource.persisted?
        flash[:notice] = "Funcionário cadastrado com sucesso!"
        redirect_to root_path and return
      end
    end
  end
end