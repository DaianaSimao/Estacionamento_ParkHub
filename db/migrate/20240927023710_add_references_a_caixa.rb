class AddReferencesACaixa < ActiveRecord::Migration[7.0]
  def change
    add_reference :caixas, :checkin, foreign_key: true
    add_reference :caixas, :forma_pagamento, foreign_key: true
    add_column :caixas, :logado, :string
  end
end
