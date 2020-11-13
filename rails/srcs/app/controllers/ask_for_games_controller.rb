class AskForGamesController < ApplicationController
  before_action :set_ask_for_game, only: [:show, :edit, :update, :destroy]

  # GET /ask_for_games
  # GET /ask_for_games.json
  def index
    if (params[:to_user_id])
      @game = AskForGame.where("to_user_id = ? AND status='playing'", params[:to_user_id]).last 
    elsif  (params[:from_user_id])
      @game = AskForGame.where("from_user_id = ? AND status='playing'", params[:from_user_id]).last
    else
       @game = AskForGame.all
    end
    respond_to do |format|
      format.html
      format.json {render json: @game}
    end
    #@ask_for_games = AskForGame.all
  end

  # GET /ask_for_games/1
  # GET /ask_for_games/1.json
  def show
  end

  # GET /ask_for_games/new
  def new
    @ask_for_game = AskForGame.new
  end

  # GET /ask_for_games/1/edit
  def edit
  end

  # POST /ask_for_games
  # POST /ask_for_games.json
  def create
    @ask_for_game = AskForGame.new(ask_for_game_params)
    respond_to do |format|
      if @ask_for_game.save
        format.html { redirect_to @ask_for_game, notice: 'Ask for game was successfully created.' }
        format.json { render :show, status: :created, location: @ask_for_game }
      else
        format.html { render :new }
        format.json { render json: @ask_for_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ask_for_games/1
  # PATCH/PUT /ask_for_games/1.json
  def update
    respond_to do |format|
      if @ask_for_game.update(ask_for_game_params)
        format.html { redirect_to @ask_for_game, notice: 'Ask for game was successfully updated.' }
        format.json { render :show, status: :ok, location: @ask_for_game }
      else
        format.html { render :edit }
        format.json { render json: @ask_for_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ask_for_games/1
  # DELETE /ask_for_games/1.json
  def destroy
    @ask_for_game.destroy
    respond_to do |format|
      format.html { redirect_to ask_for_games_url, notice: 'Ask for game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ask_for_game
      @ask_for_game = AskForGame.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ask_for_game_params
      params.require(:ask_for_game).permit(:from_user_id, :to_user_id, :status)
    end
end
