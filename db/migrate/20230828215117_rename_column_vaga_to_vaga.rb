class RenameColumnVagaToVaga < ActiveRecord::Migration[7.0]
  def change
    rename_column :vagas, :vaga, :vaga_nome
  end
end
