class PlayerReviewsController < ApplicationController
  before_action :set_player_review, only: %i[ show edit update destroy ]

  # GET /player_reviews or /player_reviews.json
  def index
    @player_reviews = PlayerReview.all
  end

  # GET /player_reviews/1 or /player_reviews/1.json
  def show
  end

  # GET /player_reviews/new
  def new
    @player_review = PlayerReview.new
  end

  # GET /player_reviews/1/edit
  def edit
  end

  # POST /player_reviews or /player_reviews.json
  def create
    @player_review = PlayerReview.new(player_review_params)

    respond_to do |format|
      if @player_review.save
        format.html { redirect_to player_review_url(@player_review), notice: "Player review was successfully created." }
        format.json { render :show, status: :created, location: @player_review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_reviews/1 or /player_reviews/1.json
  def update
    respond_to do |format|
      if @player_review.update(player_review_params)
        format.html { redirect_to player_review_url(@player_review), notice: "Player review was successfully updated." }
        format.json { render :show, status: :ok, location: @player_review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_reviews/1 or /player_reviews/1.json
  def destroy
    @player_review.destroy

    respond_to do |format|
      format.html { redirect_to player_reviews_url, notice: "Player review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_review
      @player_review = PlayerReview.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_review_params
      params.require(:player_review).permit(:rating, :player_id, :reviewer_id, :reservation_id)
    end
end
