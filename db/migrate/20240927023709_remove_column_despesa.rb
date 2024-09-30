class RemoveColumnDespesa < ActiveRecord::Migration[7.0]
  def change
    remove_column :despesas, :forma_pagamento, :string
  end
end
