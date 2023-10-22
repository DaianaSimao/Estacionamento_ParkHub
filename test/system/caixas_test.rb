require "application_system_test_case"

class CaixasTest < ApplicationSystemTestCase
  setup do
    @caixa = caixas(:one)
  end

  test "visiting the index" do
    visit caixas_url
    assert_selector "h1", text: "caixas"
  end

  test "should create caixa" do
    visit caixas_url
    click_on "New caixa"

    fill_in "Checkin", with: @caixa.checkin_id
    fill_in "Data caixa", with: @caixa.data_pagamento
    fill_in "Forma caixa", with: @caixa.forma_pagamento
    fill_in "Status", with: @caixa.status
    fill_in "Tempo estadia", with: @caixa.tempo_estadia
    fill_in "Troco", with: @caixa.troco
    fill_in "Valor", with: @caixa.valor
    click_on "Create caixa"

    assert_text "caixa was successfully created"
    click_on "Back"
  end

  test "should update caixa" do
    visit caixa_url(@caixa)
    click_on "Edit this caixa", match: :first

    fill_in "Checkin", with: @caixa.checkin_id
    fill_in "Data caixa", with: @caixa.data_pagamento
    fill_in "Forma caixa", with: @caixa.forma_pagamento
    fill_in "Status", with: @caixa.status
    fill_in "Tempo estadia", with: @caixa.tempo_estadia
    fill_in "Troco", with: @caixa.troco
    fill_in "Valor", with: @caixa.valor
    click_on "Update caixa"

    assert_text "caixa was successfully updated"
    click_on "Back"
  end

  test "should destroy caixa" do
    visit caixa_url(@caixa)
    click_on "Destroy this caixa", match: :first

    assert_text "caixa was successfully destroyed"
  end
end
