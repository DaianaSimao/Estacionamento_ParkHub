class CreateFluxoCaixas < ActiveRecord::Migration[7.0]
  def change
    create_table :fluxo_caixas do |t|
      t.string :descricao
      t.string :categoria
      t.string :tipo
      t.float :valor
      t.string :forma_pagamento
      t.string :status
      t.date :data_criacao

      t.timestamps
    end
  end
end
