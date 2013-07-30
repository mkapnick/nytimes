require 'test_helper'

class NytfilesControllerTest < ActionController::TestCase
  setup do
    @nytfile = nytfiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nytfiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nytfile" do
    assert_difference('Nytfile.count') do
      post :create, nytfile: { upload: @nytfile.upload }
    end

    assert_redirected_to nytfile_path(assigns(:nytfile))
  end

  test "should show nytfile" do
    get :show, id: @nytfile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nytfile
    assert_response :success
  end

  test "should update nytfile" do
    put :update, id: @nytfile, nytfile: { upload: @nytfile.upload }
    assert_redirected_to nytfile_path(assigns(:nytfile))
  end

  test "should destroy nytfile" do
    assert_difference('Nytfile.count', -1) do
      delete :destroy, id: @nytfile
    end

    assert_redirected_to nytfiles_path
  end
end
