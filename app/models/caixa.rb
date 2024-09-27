class Caixa < ApplicationRecord

  scope :criado_entre, -> min,max { where("caixas.created_at BETWEEN ? AND ?",min,max) }

  belongs_to :checkin
  belongs_to :forma_pagamento

  accepts_nested_attributes_for :forma_pagamento
  
  after_create :criar_fluxo_caixa

  def criar_fluxo_caixa
    FluxoCaixa.create(descricao: self.descricao, categoria: "Receita",tipo: "Entrada",
                            valor: self.forma_pagamento.valor, forma_pagamento: self.forma_pagamento.nome,
                            status: self.status, data_criacao: self.created_at)
  end
end
