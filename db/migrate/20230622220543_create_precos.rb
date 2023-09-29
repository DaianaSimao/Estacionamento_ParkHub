class CreatePrecos < ActiveRecord::Migration[7.0]
  def change
    create_table :precos do |t|
      t.float :preco_hora
      t.string :tipo 

      t.timestamps
    end
  end
end
