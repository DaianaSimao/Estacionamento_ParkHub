class CreateFormaPagamento < ActiveRecord::Migration[7.0]
  def change
    create_table :forma_pagamentos do |t|
      t.string :nome

      t.timestamps
    end
  end
end
