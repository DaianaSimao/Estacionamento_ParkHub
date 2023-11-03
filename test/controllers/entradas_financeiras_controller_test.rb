require "test_helper"

class EntradasFinanceirasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @entradas_financeira = entradas_financeiras(:one)
  end

  test "should get index" do
    get entradas_financeiras_url
    assert_response :success
  end

  test "should get new" do
    get new_entradas_financeira_url
    assert_response :success
  end

  test "should create entradas_financeira" do
    assert_difference("EntradasFinanceira.count") do
      post entradas_financeiras_url, params: { entradas_financeira: { descricao: @entradas_financeira.descricao, forma_pagamento: @entradas_financeira.forma_pagamento, obs: @entradas_financeira.obs, responsavel: @entradas_financeira.responsavel, tipo: @entradas_financeira.tipo, valor: @entradas_financeira.valor } }
    end

    assert_redirected_to entradas_financeira_url(EntradasFinanceira.last)
  end

  test "should show entradas_financeira" do
    get entradas_financeira_url(@entradas_financeira)
    assert_response :success
  end

  test "should get edit" do
    get edit_entradas_financeira_url(@entradas_financeira)
    assert_response :success
  end

  test "should update entradas_financeira" do
    patch entradas_financeira_url(@entradas_financeira), params: { entradas_financeira: { descricao: @entradas_financeira.descricao, forma_pagamento: @entradas_financeira.forma_pagamento, obs: @entradas_financeira.obs, responsavel: @entradas_financeira.responsavel, tipo: @entradas_financeira.tipo, valor: @entradas_financeira.valor } }
    assert_redirected_to entradas_financeira_url(@entradas_financeira)
  end

  test "should destroy entradas_financeira" do
    assert_difference("EntradasFinanceira.count", -1) do
      delete entradas_financeira_url(@entradas_financeira)
    end

    assert_redirected_to entradas_financeiras_url
  end
end
