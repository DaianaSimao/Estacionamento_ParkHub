class CreatePagamento < ActiveRecord::Migration[7.0]
  def change
    create_table :pagamentos do |t|
      t.references :forma_pagamento, null: false, foreign_key: true
      t.decimal :valor, precision: 10, scale: 2
      t.decimal :troco, precision: 10, scale: 2
      t.decimal :total, precision: 10, scale: 2

      t.timestamps
    end
  end
end
