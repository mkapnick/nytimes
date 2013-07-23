require 'test_helper'

class OfferChainsControllerTest < ActionController::TestCase
  setup do
    @offer_chain = offer_chains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offer_chains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offer_chain" do
    assert_difference('OfferChain.count') do
      post :create, offer_chain: { approved: @offer_chain.approved, date: @offer_chain.date }
    end

    assert_redirected_to offer_chain_path(assigns(:offer_chain))
  end

  test "should show offer_chain" do
    get :show, id: @offer_chain
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offer_chain
    assert_response :success
  end

  test "should update offer_chain" do
    put :update, id: @offer_chain, offer_chain: { approved: @offer_chain.approved, date: @offer_chain.date }
    assert_redirected_to offer_chain_path(assigns(:offer_chain))
  end

  test "should destroy offer_chain" do
    assert_difference('OfferChain.count', -1) do
      delete :destroy, id: @offer_chain
    end

    assert_redirected_to offer_chains_path
  end
end
