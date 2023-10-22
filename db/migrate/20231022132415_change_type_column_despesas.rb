class ChangeTypeColumnDespesas < ActiveRecord::Migration[7.0]
  def change
    change_column :despesas, :valor, :float
  end
end
