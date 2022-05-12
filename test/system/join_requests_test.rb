require "application_system_test_case"

class JoinRequestsTest < ApplicationSystemTestCase
  setup do
    @join_request = join_requests(:one)
  end

  test "visiting the index" do
    visit join_requests_url
    assert_selector "h1", text: "Join Requests"
  end

  test "creating a Join request" do
    visit join_requests_url
    click_on "New Join Request"

    fill_in "Player", with: @join_request.player_id
    fill_in "Reservation", with: @join_request.reservation_id
    click_on "Create Join request"

    assert_text "Join request was successfully created"
    click_on "Back"
  end

  test "updating a Join request" do
    visit join_requests_url
    click_on "Edit", match: :first

    fill_in "Player", with: @join_request.player_id
    fill_in "Reservation", with: @join_request.reservation_id
    click_on "Update Join request"

    assert_text "Join request was successfully updated"
    click_on "Back"
  end

  test "destroying a Join request" do
    visit join_requests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Join request was successfully destroyed"
  end
end
