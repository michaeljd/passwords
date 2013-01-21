require 'test_helper'

class PasswordHashesControllerTest < ActionController::TestCase
  setup do
    @password_hash = password_hashes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:password_hashes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create password_hash" do
    assert_difference('PasswordHash.count') do
      post :create, password_hash: { hash: @password_hash.hash }
    end

    assert_redirected_to password_hash_path(assigns(:password_hash))
  end

  test "should show password_hash" do
    get :show, id: @password_hash
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @password_hash
    assert_response :success
  end

  test "should update password_hash" do
    put :update, id: @password_hash, password_hash: { hash: @password_hash.hash }
    assert_redirected_to password_hash_path(assigns(:password_hash))
  end

  test "should destroy password_hash" do
    assert_difference('PasswordHash.count', -1) do
      delete :destroy, id: @password_hash
    end

    assert_redirected_to password_hashes_path
  end
end
