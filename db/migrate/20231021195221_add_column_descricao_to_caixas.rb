class AddColumnDescricaoToCaixas < ActiveRecord::Migration[7.0]
  def change
    add_column :pagamentos, :descricao, :string
  end
end
