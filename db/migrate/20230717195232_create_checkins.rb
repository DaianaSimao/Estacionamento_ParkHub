class CreateCheckins < ActiveRecord::Migration[7.0]
  def change
    create_table :checkins do |t|
      t.references :preco, null: false, foreign_key: true
      t.references :vaga, null: false, foreign_key: true
      t.boolean :status
      t.string :numero_ticket
      t.boolean :em_permanencia
      t.datetime :entrada
      t.datetime :saida

      t.timestamps
    end
  end
end
