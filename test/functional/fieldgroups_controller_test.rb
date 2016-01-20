require 'test_helper'

class FieldgroupsControllerTest < ActionController::TestCase
  setup do
    @fieldgroup = fieldgroups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fieldgroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fieldgroup" do
    assert_difference('Fieldgroup.count') do
      post :create, fieldgroup: { bounds: @fieldgroup.bounds, description: @fieldgroup.description, height: @fieldgroup.height, help: @fieldgroup.help, name: @fieldgroup.name, resizable: @fieldgroup.resizable, width: @fieldgroup.width, zoom: @fieldgroup.zoom }
    end

    assert_redirected_to fieldgroup_path(assigns(:fieldgroup))
  end

  test "should show fieldgroup" do
    get :show, id: @fieldgroup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fieldgroup
    assert_response :success
  end

  test "should update fieldgroup" do
    put :update, id: @fieldgroup, fieldgroup: { bounds: @fieldgroup.bounds, description: @fieldgroup.description, height: @fieldgroup.height, help: @fieldgroup.help, name: @fieldgroup.name, resizable: @fieldgroup.resizable, width: @fieldgroup.width, zoom: @fieldgroup.zoom }
    assert_redirected_to fieldgroup_path(assigns(:fieldgroup))
  end

  test "should destroy fieldgroup" do
    assert_difference('Fieldgroup.count', -1) do
      delete :destroy, id: @fieldgroup
    end

    assert_redirected_to fieldgroups_path
  end
end
