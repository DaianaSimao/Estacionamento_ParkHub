class RemoveColumnToCheckin < ActiveRecord::Migration[7.0]
  def change
    remove_column :checkins, :veiculo_cor
    remove_column :checkins, :veiculo_modelo
    remove_column :checkins, :veiculo_marca
  end
end
