# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_09_26_190236) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "caixas", force: :cascade do |t|
    t.string "tempo_estadia"
    t.string "status"
    t.string "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "checkins", force: :cascade do |t|
    t.bigint "preco_id", null: false
    t.bigint "vaga_id", null: false
    t.boolean "status"
    t.string "numero_ticket"
    t.boolean "em_permanencia"
    t.datetime "entrada"
    t.datetime "saida"
    t.string "veiculo_placa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "caixa_id"
    t.index ["caixa_id"], name: "index_checkins_on_caixa_id"
    t.index ["preco_id"], name: "index_checkins_on_preco_id"
    t.index ["vaga_id"], name: "index_checkins_on_vaga_id"
  end

  create_table "despesas", force: :cascade do |t|
    t.string "descricao"
    t.float "valor"
    t.string "categoria"
    t.string "forma_pagamento"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entradas_financeiras", force: :cascade do |t|
    t.string "tipo"
    t.string "descricao"
    t.float "total"
    t.string "forma_pagamento"
    t.string "responsavel"
    t.string "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fluxo_caixas", force: :cascade do |t|
    t.string "descricao"
    t.string "categoria"
    t.string "tipo"
    t.float "valor"
    t.string "forma_pagamento"
    t.string "status"
    t.date "data_criacao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forma_pagamentos", force: :cascade do |t|
    t.string "nome"
    t.decimal "valor", precision: 10, scale: 2
    t.decimal "troco", precision: 10, scale: 2
    t.decimal "total", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "checkin_id"
    t.index ["checkin_id"], name: "index_forma_pagamentos_on_checkin_id"
  end

  create_table "precos", force: :cascade do |t|
    t.float "preco_hora"
    t.string "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vagas", force: :cascade do |t|
    t.string "vaga_nome"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "veiculos", force: :cascade do |t|
    t.string "placa"
    t.string "marca"
    t.string "modelo"
    t.string "cor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "checkins", "caixas"
  add_foreign_key "checkins", "precos"
  add_foreign_key "checkins", "vagas"
  add_foreign_key "forma_pagamentos", "checkins"
end
