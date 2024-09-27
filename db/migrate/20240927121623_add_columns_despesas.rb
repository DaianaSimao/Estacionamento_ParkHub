class AddColumnsDespesas < ActiveRecord::Migration[7.0]
  def change
    add_column :despesas, :data_pagamento, :date
    add_column :despesas, :data_vencimento, :date
  end
end
