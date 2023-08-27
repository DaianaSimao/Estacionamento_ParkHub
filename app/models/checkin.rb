class Checkin < ApplicationRecord
  belongs_to :preco
  belongs_to :vaga
  
  after_create :atualizar_status_vaga
  after_update :atualizar_status_vaga

  def calcular_preco
    hora_entrada = self.created_at
    hora_saida = self.updated_at
    diferenca_horas = ((hora_saida - hora_entrada) / 1.hour).ceil
    valor_por_hora = self.preco.preco_hora
    valor_minimo = valor_por_hora
    preco_a_cobrar = [diferenca_horas * valor_por_hora, valor_minimo].max
    return preco_a_cobrar
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