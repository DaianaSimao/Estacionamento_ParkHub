class RemoveColumnCaixa < ActiveRecord::Migration[7.0]
  def change
    remove_column :caixas, :forma_pagamento, :string
    remove_column :caixas, :troco, :decimal
    remove_column :caixas, :total, :decimal
    remove_column :caixas, :valor, :decimal
    remove_column :caixas, :data_pagamento, :datetime
    remove_column :caixas, :checkin_id, :integer
  end
end
