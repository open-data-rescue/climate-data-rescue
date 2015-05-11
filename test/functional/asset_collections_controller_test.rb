require 'test_helper'

class AssetCollectionsControllerTest < ActionController::TestCase
  setup do
    @asset_collection = asset_collections(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asset_collections)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asset_collection" do
    assert_difference('AssetCollection.count') do
      post :create, asset_collection: { author: @asset_collection.author, extern_ref: @asset_collection.extern_ref, title: @asset_collection.title }
    end

    assert_redirected_to asset_collection_path(assigns(:asset_collection))
  end

  test "should show asset_collection" do
    get :show, id: @asset_collection
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asset_collection
    assert_response :success
  end

  test "should update asset_collection" do
    put :update, id: @asset_collection, asset_collection: { author: @asset_collection.author, extern_ref: @asset_collection.extern_ref, title: @asset_collection.title }
    assert_redirected_to asset_collection_path(assigns(:asset_collection))
  end

  test "should destroy asset_collection" do
    assert_difference('AssetCollection.count', -1) do
      delete :destroy, id: @asset_collection
    end

    assert_redirected_to asset_collections_path
  end
end
