require "application_system_test_case"

class EntradasFinanceirasTest < ApplicationSystemTestCase
  setup do
    @entradas_financeira = entradas_financeiras(:one)
  end

  test "visiting the index" do
    visit entradas_financeiras_url
    assert_selector "h1", text: "Entradas financeiras"
  end

  test "should create entradas financeira" do
    visit entradas_financeiras_url
    click_on "New entradas financeira"

    fill_in "Descricao", with: @entradas_financeira.descricao
    fill_in "Forma pagamento", with: @entradas_financeira.forma_pagamento
    fill_in "Obs", with: @entradas_financeira.obs
    fill_in "Responsavel", with: @entradas_financeira.responsavel
    fill_in "Tipo", with: @entradas_financeira.tipo
    fill_in "Valor", with: @entradas_financeira.valor
    click_on "Create Entradas financeira"

    assert_text "Entradas financeira was successfully created"
    click_on "Back"
  end

  test "should update Entradas financeira" do
    visit entradas_financeira_url(@entradas_financeira)
    click_on "Edit this entradas financeira", match: :first

    fill_in "Descricao", with: @entradas_financeira.descricao
    fill_in "Forma pagamento", with: @entradas_financeira.forma_pagamento
    fill_in "Obs", with: @entradas_financeira.obs
    fill_in "Responsavel", with: @entradas_financeira.responsavel
    fill_in "Tipo", with: @entradas_financeira.tipo
    fill_in "Valor", with: @entradas_financeira.valor
    click_on "Update Entradas financeira"

    assert_text "Entradas financeira was successfully updated"
    click_on "Back"
  end

  test "should destroy Entradas financeira" do
    visit entradas_financeira_url(@entradas_financeira)
    click_on "Destroy this entradas financeira", match: :first

    assert_text "Entradas financeira was successfully destroyed"
  end
end
