class CreateFormaPagamento < ActiveRecord::Migration[7.0]
  def change
    create_table :forma_pagamentos do |t|
      t.string :nome
      t.decimal :valor, precision: 10, scale: 2
      t.decimal :troco, precision: 10, scale: 2
      t.decimal :total, precision: 10, scale: 2

      t.timestamps
    end
  end
end
