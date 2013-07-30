require 'test_helper'

class NytEfilesControllerTest < ActionController::TestCase
  setup do
    @nyt_efile = nyt_efiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nyt_efiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nyt_efile" do
    assert_difference('NytEfile.count') do
      post :create, nyt_efile: { upload: @nyt_efile.upload }
    end

    assert_redirected_to nyt_efile_path(assigns(:nyt_efile))
  end

  test "should show nyt_efile" do
    get :show, id: @nyt_efile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nyt_efile
    assert_response :success
  end

  test "should update nyt_efile" do
    put :update, id: @nyt_efile, nyt_efile: { upload: @nyt_efile.upload }
    assert_redirected_to nyt_efile_path(assigns(:nyt_efile))
  end

  test "should destroy nyt_efile" do
    assert_difference('NytEfile.count', -1) do
      delete :destroy, id: @nyt_efile
    end

    assert_redirected_to nyt_efiles_path
  end
end
