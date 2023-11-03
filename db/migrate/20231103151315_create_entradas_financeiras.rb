class CreateEntradasFinanceiras < ActiveRecord::Migration[7.0]
  def change
    create_table :entradas_financeiras do |t|
      t.string :tipo
      t.string :descricao
      t.float :total
      t.string :forma_pagamento
      t.string :responsavel
      t.string :obs

      t.timestamps
    end
  end
end
