class Checkin < ApplicationRecord
  belongs_to :preco
  belongs_to :vaga
  
  
  after_create :atualizar_status_vaga
  after_update :atualizar_status_vaga
  before_save :transformar_em_maiusculas

  def transformar_em_maiusculas
    self.veiculo_cor = veiculo_cor.upcase if veiculo_cor.present?
    self.veiculo_placa = veiculo_placa.upcase if veiculo_placa.present?
    self.veiculo_modelo = veiculo_modelo.upcase if veiculo_modelo.present?
    self.veiculo_marca = veiculo_marca.upcase if veiculo_marca.present?
    self.veiculo_placa = veiculo_placa.upcase if veiculo_placa.present?
  end

  def calcular_valor_cobrado
    hora_entrada = self.created_at
    hora_saida = self.updated_at

    diferenca_segundos = hora_saida - hora_entrada

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
end