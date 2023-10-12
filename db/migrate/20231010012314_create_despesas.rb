class CreateDespesas < ActiveRecord::Migration[7.0]
  def change
    create_table :despesas do |t|
      t.string :descricao
      t.string :valor
      t.string :categoria
      t.string :forma_pagamento
      t.string :status

      t.timestamps
    end
  end
end
