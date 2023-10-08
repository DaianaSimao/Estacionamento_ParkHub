class AddColumnToPagamentos < ActiveRecord::Migration[7.0]
  def change
    add_column :pagamentos, :total, :float
  end
end
