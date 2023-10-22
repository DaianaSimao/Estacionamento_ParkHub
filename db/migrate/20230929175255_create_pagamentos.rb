class Createcaixas < ActiveRecord::Migration[7.0]
  def change
    create_table :pagamentos do |t|
      t.references :checkin, null: false, foreign_key: true
      t.string :forma_pagamento
      t.float :valor
      t.float :troco
      t.date :data_pagamento
      t.string :tempo_estadia
      t.string :status
      t.float :total

      t.timestamps
    end
  end
end
