require "application_system_test_case"

class ActuatorsTest < ApplicationSystemTestCase
  setup do
    @actuator = actuators(:one)
  end

  test "visiting the index" do
    visit actuators_url
    assert_selector "h1", text: "Actuators"
  end

  test "should create actuator" do
    visit actuators_url
    click_on "New actuator"

    click_on "Create Actuator"

    assert_text "Actuator was successfully created"
    click_on "Back"
  end

  test "should update Actuator" do
    visit actuator_url(@actuator)
    click_on "Edit this actuator", match: :first

    click_on "Update Actuator"

    assert_text "Actuator was successfully updated"
    click_on "Back"
  end

  test "should destroy Actuator" do
    visit actuator_url(@actuator)
    click_on "Destroy this actuator", match: :first

    assert_text "Actuator was successfully destroyed"
  end
end
