class Caixa < ApplicationRecord
  belongs_to :checkin

  validates :checkin_id, presence: true
  validates :checkin_id, uniqueness: { notice: "já existe um registro com este Checkin ID" }

  scope :criado_entre, -> min,max { where("caixas.created_at BETWEEN ? AND ?",min,max) }

  after_create :criar_fluxo_caixa
  
  def criar_fluxo_caixa
    FluxoCaixa.create(descricao: self.descricao, categoria: "Receita",tipo: "Entrada",
                            valor: self.total, forma_pagamento: self.forma_pagamento,
                            status: self.status, data_criacao: self.created_at)
  end
end
