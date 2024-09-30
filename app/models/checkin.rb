class Checkin < ApplicationRecord
  belongs_to :preco
  belongs_to :vaga
  
  has_paper_trail
  
  after_create :atualizar_status_vaga
  before_update :atualizar_saida
  after_update :atualizar_status_vaga
  before_create :atualizar_entrada
  before_save :transformar_em_maiusculas

  scope :criado_entre, -> min,max { where("checkins.created_at BETWEEN ? AND ?",min,max) }

  def transformar_em_maiusculas
    self.veiculo_placa = veiculo_placa.upcase if veiculo_placa.present?
  end

  def calcular_valor_cobrado  
    valor_total = TicketService.calcular_valor_cobrado(self)
    valor_total
  end
  
  def pago?
    Caixa.where(checkin_id: self.id).first.present?
  end

  private

  def atualizar_status_vaga
    begin 
      if self.status == true && self.vaga.status == false
        self.vaga.update(status: true)
      elsif self.status == false && self.vaga.status == true
        self.vaga.update(status: false)
      end
    rescue => exception
      puts exception
    end
  end

  def atualizar_entrada
    self.entrada = Time.now - 3.hours
  end

  def atualizar_saida
    self.saida = Time.now - 3.hours
  end
end
