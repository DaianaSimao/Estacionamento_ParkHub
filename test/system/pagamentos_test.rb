require "application_system_test_case"

class PagamentosTest < ApplicationSystemTestCase
  setup do
    @pagamento = pagamentos(:one)
  end

  test "visiting the index" do
    visit pagamentos_url
    assert_selector "h1", text: "Pagamentos"
  end

  test "should create pagamento" do
    visit pagamentos_url
    click_on "New pagamento"

    fill_in "Checkin", with: @pagamento.checkin_id
    fill_in "Data pagamento", with: @pagamento.data_pagamento
    fill_in "Forma pagamento", with: @pagamento.forma_pagamento
    fill_in "Status", with: @pagamento.status
    fill_in "Tempo estadia", with: @pagamento.tempo_estadia
    fill_in "Troco", with: @pagamento.troco
    fill_in "Valor", with: @pagamento.valor
    click_on "Create Pagamento"

    assert_text "Pagamento was successfully created"
    click_on "Back"
  end

  test "should update Pagamento" do
    visit pagamento_url(@pagamento)
    click_on "Edit this pagamento", match: :first

    fill_in "Checkin", with: @pagamento.checkin_id
    fill_in "Data pagamento", with: @pagamento.data_pagamento
    fill_in "Forma pagamento", with: @pagamento.forma_pagamento
    fill_in "Status", with: @pagamento.status
    fill_in "Tempo estadia", with: @pagamento.tempo_estadia
    fill_in "Troco", with: @pagamento.troco
    fill_in "Valor", with: @pagamento.valor
    click_on "Update Pagamento"

    assert_text "Pagamento was successfully updated"
    click_on "Back"
  end

  test "should destroy Pagamento" do
    visit pagamento_url(@pagamento)
    click_on "Destroy this pagamento", match: :first

    assert_text "Pagamento was successfully destroyed"
  end
end
