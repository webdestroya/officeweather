require 'test_helper'

class TempReadingsControllerTest < ActionController::TestCase
  setup do
    @temp_reading = temp_readings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:temp_readings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create temp_reading" do
    assert_difference('TempReading.count') do
      post :create, temp_reading: { temperature: @temp_reading.temperature }
    end

    assert_redirected_to temp_reading_path(assigns(:temp_reading))
  end

  test "should show temp_reading" do
    get :show, id: @temp_reading
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @temp_reading
    assert_response :success
  end

  test "should update temp_reading" do
    put :update, id: @temp_reading, temp_reading: { temperature: @temp_reading.temperature }
    assert_redirected_to temp_reading_path(assigns(:temp_reading))
  end

  test "should destroy temp_reading" do
    assert_difference('TempReading.count', -1) do
      delete :destroy, id: @temp_reading
    end

    assert_redirected_to temp_readings_path
  end
end
