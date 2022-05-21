require "test_helper"

class PlayerReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_review = player_reviews(:one)
  end

  test "should get index" do
    get player_reviews_url
    assert_response :success
  end

  test "should get new" do
    get new_player_review_url
    assert_response :success
  end

  test "should create player_review" do
    assert_difference('PlayerReview.count') do
      post player_reviews_url, params: { player_review: { player_id: @player_review.player_id, rating: @player_review.rating, reservation_id: @player_review.reservation_id, reviewer_id: @player_review.reviewer_id } }
    end

    assert_redirected_to player_review_url(PlayerReview.last)
  end

  test "should show player_review" do
    get player_review_url(@player_review)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_review_url(@player_review)
    assert_response :success
  end

  test "should update player_review" do
    patch player_review_url(@player_review), params: { player_review: { player_id: @player_review.player_id, rating: @player_review.rating, reservation_id: @player_review.reservation_id, reviewer_id: @player_review.reviewer_id } }
    assert_redirected_to player_review_url(@player_review)
  end

  test "should destroy player_review" do
    assert_difference('PlayerReview.count', -1) do
      delete player_review_url(@player_review)
    end

    assert_redirected_to player_reviews_url
  end
end
