require 'test_helper'

class CollectionGroupsControllerTest < ActionController::TestCase
  setup do
    @collection_group = collection_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:collection_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create collection_group" do
    assert_difference('CollectionGroup.count') do
      post :create, collection_group: {  }
    end

    assert_redirected_to collection_group_path(assigns(:collection_group))
  end

  test "should show collection_group" do
    get :show, id: @collection_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @collection_group
    assert_response :success
  end

  test "should update collection_group" do
    put :update, id: @collection_group, collection_group: {  }
    assert_redirected_to collection_group_path(assigns(:collection_group))
  end

  test "should destroy collection_group" do
    assert_difference('CollectionGroup.count', -1) do
      delete :destroy, id: @collection_group
    end

    assert_redirected_to collection_groups_path
  end
end
