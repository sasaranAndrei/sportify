require "application_system_test_case"

class PlayerReviewsTest < ApplicationSystemTestCase
  setup do
    @player_review = player_reviews(:one)
  end

  test "visiting the index" do
    visit player_reviews_url
    assert_selector "h1", text: "Player Reviews"
  end

  test "creating a Player review" do
    visit player_reviews_url
    click_on "New Player Review"

    fill_in "Player", with: @player_review.player_id
    fill_in "Rating", with: @player_review.rating
    fill_in "Reservation", with: @player_review.reservation_id
    fill_in "Reviewer", with: @player_review.reviewer_id
    click_on "Create Player review"

    assert_text "Player review was successfully created"
    click_on "Back"
  end

  test "updating a Player review" do
    visit player_reviews_url
    click_on "Edit", match: :first

    fill_in "Player", with: @player_review.player_id
    fill_in "Rating", with: @player_review.rating
    fill_in "Reservation", with: @player_review.reservation_id
    fill_in "Reviewer", with: @player_review.reviewer_id
    click_on "Update Player review"

    assert_text "Player review was successfully updated"
    click_on "Back"
  end

  test "destroying a Player review" do
    visit player_reviews_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Player review was successfully destroyed"
  end
end
