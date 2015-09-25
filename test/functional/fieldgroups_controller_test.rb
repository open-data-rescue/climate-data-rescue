require 'test_helper'

class FieldgroupsControllerTest < ActionController::TestCase
  setup do
    @fieldgroups = fieldgroups(:one)
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

  test "should create fieldgroups" do
    assert_difference('Fieldgroup.count') do
      post :create, fieldgroups: { bounds: @fieldgroups.bounds, description: @fieldgroups.description, height: @fieldgroups.height, help: @fieldgroups.help, name: @fieldgroups.name, resizable: @fieldgroups.resizable, width: @fieldgroups.width, zoom: @fieldgroups.zoom }
    end

    assert_redirected_to fieldgroups_path(assigns(:fieldgroups))
  end

  test "should show fieldgroups" do
    get :show, id: @fieldgroups
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fieldgroups
    assert_response :success
  end

  test "should update fieldgroups" do
    put :update, id: @fieldgroups, fieldgroups: { bounds: @fieldgroups.bounds, description: @fieldgroups.description, height: @fieldgroups.height, help: @fieldgroups.help, name: @fieldgroups.name, resizable: @fieldgroups.resizable, width: @fieldgroups.width, zoom: @fieldgroups.zoom }
    assert_redirected_to fieldgroups_path(assigns(:fieldgroups))
  end

  test "should destroy fieldgroups" do
    assert_difference('Fieldgroup.count', -1) do
      delete :destroy, id: @fieldgroups
    end

    assert_redirected_to fieldgroups_path
  end
end
