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

    diferenca_segundos = saida - entrada

    minutos_permanencia_total = (diferenca_segundos / 1.minute).ceil
  
    taxa_horaria = self.preco.preco_hora / 60 
    
    valor_total = minutos_permanencia_total * taxa_horaria
    valor_total
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