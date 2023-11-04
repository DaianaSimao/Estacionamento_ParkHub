class EntradasFinanceira < ApplicationRecord

  after_create :criar_fluxo_caixa

  scope :criado_entre, -> min,max { where("entradas_financeiras.created_at BETWEEN ? AND ?",min,max) }
  
  def criar_fluxo_caixa
    FluxoCaixa.create(descricao: self.descricao, categoria: "Receita",tipo: "Entrada",
                            valor: self.total, forma_pagamento: self.forma_pagamento,
                            status: "Pago", data_criacao: self.created_at)
  end
end
