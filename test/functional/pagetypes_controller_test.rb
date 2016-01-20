require 'test_helper'

class PagetypesControllerTest < ActionController::TestCase
  setup do
    @pagetype = pagetypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pagetypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pagetype" do
    assert_difference('Pagetype.count') do
      post :create, pagetype: { author: @pagetype.author, extern_ref: @pagetype.extern_ref, title: @pagetype.title }
    end

    assert_redirected_to pagetype_path(assigns(:pagetype))
  end

  test "should show pagetype" do
    get :show, id: @pagetype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pagetype
    assert_response :success
  end

  test "should update pagetype" do
    put :update, id: @pagetype, pagetype: { author: @pagetype.author, extern_ref: @pagetype.extern_ref, title: @pagetype.title }
    assert_redirected_to pagetype_path(assigns(:pagetype))
  end

  test "should destroy pagetype" do
    assert_difference('Pagetype.count', -1) do
      delete :destroy, id: @pagetype
    end

    assert_redirected_to pagetypes_path
  end
end
