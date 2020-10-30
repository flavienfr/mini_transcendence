class AskForFriendshipsController < ApplicationController
  before_action :set_ask_for_friendship, only: [:show, :edit, :update, :destroy]

  # GET /ask_for_friendships
  # GET /ask_for_friendships.json
  def index
    @ask_for_friendships = AskForFriendship.all
  end

  # GET /ask_for_friendships/1
  # GET /ask_for_friendships/1.json
  def show
  end

  # GET /ask_for_friendships/new
  def new
    @ask_for_friendship = AskForFriendship.new
  end

  # GET /ask_for_friendships/1/edit
  def edit
  end

  # POST /ask_for_friendships
  # POST /ask_for_friendships.json
  def create
    @ask_for_friendship = AskForFriendship.new(ask_for_friendship_params)

    respond_to do |format|
      if @ask_for_friendship.save
        format.html { redirect_to @ask_for_friendship, notice: 'Ask for friendship was successfully created.' }
        format.json { render :show, status: :created, location: @ask_for_friendship }
      else
        format.html { render :new }
        format.json { render json: @ask_for_friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ask_for_friendships/1
  # PATCH/PUT /ask_for_friendships/1.json
  def update
    respond_to do |format|
      if @ask_for_friendship.update(ask_for_friendship_params)
        format.html { redirect_to @ask_for_friendship, notice: 'Ask for friendship was successfully updated.' }
        format.json { render :show, status: :ok, location: @ask_for_friendship }
      else
        format.html { render :edit }
        format.json { render json: @ask_for_friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ask_for_friendships/1
  # DELETE /ask_for_friendships/1.json
  def destroy
    @ask_for_friendship.destroy
    respond_to do |format|
      format.html { redirect_to ask_for_friendships_url, notice: 'Ask for friendship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ask_for_friendship
      @ask_for_friendship = AskForFriendship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ask_for_friendship_params
      params.require(:ask_for_friendship).permit(:from_user_id, :to_user_id, :friendship_id, :status)
    end
end
