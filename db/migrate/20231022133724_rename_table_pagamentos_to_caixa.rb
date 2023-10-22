class RenameTablePagamentosToCaixa < ActiveRecord::Migration[7.0]
  def change
    rename_table :pagamentos, :caixas
  end
end
