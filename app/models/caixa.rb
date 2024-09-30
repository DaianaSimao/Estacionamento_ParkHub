class Caixa < ApplicationRecord

  scope :criado_entre, -> min,max { where("caixas.created_at BETWEEN ? AND ?",min,max) }

  belongs_to :checkin
  belongs_to :pagamento

  accepts_nested_attributes_for :pagamento
  
  after_create :criar_fluxo_caixa

  def criar_fluxo_caixa
    FluxoCaixa.create(descricao: self.descricao, categoria: "Receita",tipo: "Entrada",
                            valor: self.pagamento.valor, forma_pagamento: self.pagamento.forma_pagamento.nome,
                            status: self.status, data_criacao: self.created_at)
  end
end
