class Despesa < ApplicationRecord
  belongs_to :forma_pagamento
  
  self.table_name = "despesas"

  validates :data_pagamento, presence: true
  validates :forma_pagamento, presence: true
  validates :valor, presence: true
  validates :descricao, presence: true

  after_create :criar_fluxo_caixa
  scope :criado_entre, -> min,max {where("despesas.created_at BETWEEN ? AND ?", min,max)}
  
  def criar_fluxo_caixa
    FluxoCaixa.create(descricao: self.descricao, categoria: self.categoria, tipo: "Saida",
                      valor: self.valor, forma_pagamento: self.forma_pagamento,
                      status: self.status, data_criacao: self.created_at)
  end
end
