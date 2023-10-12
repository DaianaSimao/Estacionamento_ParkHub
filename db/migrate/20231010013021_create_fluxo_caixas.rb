class CreateFluxoCaixas < ActiveRecord::Migration[7.0]
  def change
    create_table :fluxo_caixas do |t|
      t.references :pagamento, null: false, foreign_key: true
      t.references :despesas, null: false, foreign_key: true
      t.string :descricao
      t.boolean :transacao
      t.float :valor
      t.float :saldo_atual
      t.string :categoria
      t.string :metodo_pagamento
      t.string :id_referencia
      t.date :data_vencimento
      t.date :data_pagamento

      t.timestamps
    end
  end
end
