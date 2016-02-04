require 'test_helper'

class LedgersControllerTest < ActionController::TestCase
  setup do
    @ledger = ledgers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ledgers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ledger" do
    assert_difference('Ledger.count') do
      post :create, ledger: {  }
    end

    assert_redirected_to ledger_path(assigns(:ledger))
  end

  test "should show ledger" do
    get :show, id: @ledger
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ledger
    assert_response :success
  end

  test "should update ledger" do
    put :update, id: @ledger, ledger: {  }
    assert_redirected_to ledger_path(assigns(:ledger))
  end

  test "should destroy ledger" do
    assert_difference('Ledger.count', -1) do
      delete :destroy, id: @ledger
    end

    assert_redirected_to ledgers_path
  end
end
