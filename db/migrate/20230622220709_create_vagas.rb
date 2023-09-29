class CreateVagas < ActiveRecord::Migration[7.0]
  def change
    create_table :vagas do |t|
      t.string :vaga_nome
      t.boolean :status

      t.timestamps
    end
  end
end
