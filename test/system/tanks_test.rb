require "application_system_test_case"

class TanksTest < ApplicationSystemTestCase
  setup do
    @tank = tanks(:one)
  end

  test "visiting the index" do
    visit tanks_url
    assert_selector "h1", text: "Tanks"
  end

  test "should create tank" do
    visit tanks_url
    click_on "New tank"

    click_on "Create Tank"

    assert_text "Tank was successfully created"
    click_on "Back"
  end

  test "should update Tank" do
    visit tank_url(@tank)
    click_on "Edit this tank", match: :first

    click_on "Update Tank"

    assert_text "Tank was successfully updated"
    click_on "Back"
  end

  test "should destroy Tank" do
    visit tank_url(@tank)
    click_on "Destroy this tank", match: :first

    assert_text "Tank was successfully destroyed"
  end
end
