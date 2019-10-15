require 'test_helper'

class JobApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get job_applications_index_url
    assert_response :success
  end

  test "should get show" do
    get job_applications_show_url
    assert_response :success
  end

  test "should get new" do
    get job_applications_new_url
    assert_response :success
  end

  test "should get edit" do
    get job_applications_edit_url
    assert_response :success
  end

end
