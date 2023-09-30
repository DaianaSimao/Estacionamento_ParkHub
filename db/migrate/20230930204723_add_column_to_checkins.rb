class AddColumnToCheckins < ActiveRecord::Migration[7.0]
  def change
    add_column :checkins, :veiculo_placa, :string
  end
end
