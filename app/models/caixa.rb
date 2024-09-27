class Caixa < ApplicationRecord

  scope :criado_entre, -> min,max { where("caixas.created_at BETWEEN ? AND ?",min,max) }

  after_create :criar_fluxo_caixa
  
  def criar_fluxo_caixa
    
    FluxoCaixa.create(descricao: self.descricao, categoria: "Receita",tipo: "Entrada",
                            valor: self.checkin.forma_pagamento.total, forma_pagamento: self.checkin.forma_pagamento.nome,
                            status: self.status, data_criacao: self.created_at)
  end
end
