class Checkin < ApplicationRecord
  belongs_to :preco
  belongs_to :vaga
  
  
  after_create :atualizar_status_vaga
  before_update :atualizar_saida
  after_update :atualizar_status_vaga
  before_create :atualizar_entrada
  before_save :transformar_em_maiusculas

  def transformar_em_maiusculas
    self.veiculo_placa = veiculo_placa.upcase if veiculo_placa.present?
  end

  def calcular_valor_cobrado  
    valor_total = TicketService.calcular_valor_cobrado(self)
    valor_total
  end
  
  def pago?
    Caixa.exists?(checkin_id: self.id)
  end

  private

  def atualizar_status_vaga
    if self.status == true
      self.vaga.update(status: true)
    else
      self.vaga.update(status: false)
    end
  end

  def atualizar_entrada
    self.entrada = Time.now - 3.hours
  end

  def atualizar_saida
    self.saida = Time.now - 3.hours
  end
end