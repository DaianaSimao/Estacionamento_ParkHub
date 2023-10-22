require "test_helper"

class CaixasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @caixa = caixas(:one)
  end

  test "should get index" do
    get caixas_url
    assert_response :success
  end

  test "should get new" do
    get new_caixa_url
    assert_response :success
  end

  test "should create caixa" do
    assert_difference("caixa.count") do
      post caixas_url, params: { caixa: { checkin_id: @caixa.checkin_id, data_pagamento: @caixa.data_pagamento, forma_pagamento: @caixa.forma_pagamento, status: @caixa.status, tempo_estadia: @caixa.tempo_estadia, troco: @caixa.troco, valor: @caixa.valor } }
    end

    assert_redirected_to caixa_url(caixa.last)
  end

  test "should show caixa" do
    get caixa_url(@caixa)
    assert_response :success
  end

  test "should get edit" do
    get edit_caixa_url(@caixa)
    assert_response :success
  end

  test "should update caixa" do
    patch caixa_url(@caixa), params: { caixa: { checkin_id: @caixa.checkin_id, data_pagamento: @caixa.data_pagamento, forma_pagamento: @caixa.forma_pagamento, status: @caixa.status, tempo_estadia: @caixa.tempo_estadia, troco: @caixa.troco, valor: @caixa.valor } }
    assert_redirected_to caixa_url(@caixa)
  end

  test "should destroy caixa" do
    assert_difference("caixa.count", -1) do
      delete caixa_url(@caixa)
    end

    assert_redirected_to caixas_url
  end
end
