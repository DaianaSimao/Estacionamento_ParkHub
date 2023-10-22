require "application_system_test_case"

class FluxoCaixasTest < ApplicationSystemTestCase
  setup do
    @fluxo_caixa = fluxo_caixas(:one)
  end

  test "visiting the index" do
    visit fluxo_caixas_url
    assert_selector "h1", text: "Fluxo caixas"
  end

  test "should create fluxo caixa" do
    visit fluxo_caixas_url
    click_on "New fluxo caixa"

    fill_in "Categoria", with: @fluxo_caixa.categoria
    fill_in "Data vencimento", with: @fluxo_caixa.data_vencimento
    fill_in "Descricao", with: @fluxo_caixa.descricao
    fill_in "Forma pagamento", with: @fluxo_caixa.forma_pagamento
    fill_in "Status", with: @fluxo_caixa.status
    fill_in "Tipo", with: @fluxo_caixa.tipo
    fill_in "Valor", with: @fluxo_caixa.valor
    click_on "Create Fluxo caixa"

    assert_text "Fluxo caixa was successfully created"
    click_on "Back"
  end

  test "should update Fluxo caixa" do
    visit fluxo_caixa_url(@fluxo_caixa)
    click_on "Edit this fluxo caixa", match: :first

    fill_in "Categoria", with: @fluxo_caixa.categoria
    fill_in "Data vencimento", with: @fluxo_caixa.data_vencimento
    fill_in "Descricao", with: @fluxo_caixa.descricao
    fill_in "Forma pagamento", with: @fluxo_caixa.forma_pagamento
    fill_in "Status", with: @fluxo_caixa.status
    fill_in "Tipo", with: @fluxo_caixa.tipo
    fill_in "Valor", with: @fluxo_caixa.valor
    click_on "Update Fluxo caixa"

    assert_text "Fluxo caixa was successfully updated"
    click_on "Back"
  end

  test "should destroy Fluxo caixa" do
    visit fluxo_caixa_url(@fluxo_caixa)
    click_on "Destroy this fluxo caixa", match: :first

    assert_text "Fluxo caixa was successfully destroyed"
  end
end
