class AddReferencesAFormaPagamento < ActiveRecord::Migration[7.0]
  def change
    add_reference :forma_pagamentos, :checkin, foreign_key: true
  end
end
