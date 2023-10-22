require "test_helper"

class FluxoCaixasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fluxo_caixa = fluxo_caixas(:one)
  end

  test "should get index" do
    get fluxo_caixas_url
    assert_response :success
  end

  test "should get new" do
    get new_fluxo_caixa_url
    assert_response :success
  end

  test "should create fluxo_caixa" do
    assert_difference("FluxoCaixa.count") do
      post fluxo_caixas_url, params: { fluxo_caixa: { categoria: @fluxo_caixa.categoria, data_vencimento: @fluxo_caixa.data_vencimento, descricao: @fluxo_caixa.descricao, forma_pagamento: @fluxo_caixa.forma_pagamento, status: @fluxo_caixa.status, tipo: @fluxo_caixa.tipo, valor: @fluxo_caixa.valor } }
    end

    assert_redirected_to fluxo_caixa_url(FluxoCaixa.last)
  end

  test "should show fluxo_caixa" do
    get fluxo_caixa_url(@fluxo_caixa)
    assert_response :success
  end

  test "should get edit" do
    get edit_fluxo_caixa_url(@fluxo_caixa)
    assert_response :success
  end

  test "should update fluxo_caixa" do
    patch fluxo_caixa_url(@fluxo_caixa), params: { fluxo_caixa: { categoria: @fluxo_caixa.categoria, data_vencimento: @fluxo_caixa.data_vencimento, descricao: @fluxo_caixa.descricao, forma_pagamento: @fluxo_caixa.forma_pagamento, status: @fluxo_caixa.status, tipo: @fluxo_caixa.tipo, valor: @fluxo_caixa.valor } }
    assert_redirected_to fluxo_caixa_url(@fluxo_caixa)
  end

  test "should destroy fluxo_caixa" do
    assert_difference("FluxoCaixa.count", -1) do
      delete fluxo_caixa_url(@fluxo_caixa)
    end

    assert_redirected_to fluxo_caixas_url
  end
end
