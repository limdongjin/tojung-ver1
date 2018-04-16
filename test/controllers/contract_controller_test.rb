require 'test_helper'

class ContractControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get contract_index_url
    assert_response :success
  end

  test "should get new" do
    get contract_new_url
    assert_response :success
  end

  test "should get edit" do
    get contract_edit_url
    assert_response :success
  end

  test "should get update" do
    get contract_update_url
    assert_response :success
  end

  test "should get create" do
    get contract_create_url
    assert_response :success
  end

  test "should get delete" do
    get contract_delete_url
    assert_response :success
  end

end
