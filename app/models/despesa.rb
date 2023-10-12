class Despesa < ApplicationRecord
  
  self.table_name = "despesas"

  validates :data_vencimento, presence: true
  validates :forma_pagamento, presence: true
  validates :valor, presence: true
  validates :descricao, presence: true
end
