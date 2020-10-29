class AskForWarsController < ApplicationController
  before_action :set_ask_for_war, only: [:show, :edit, :update, :destroy]

  # GET /ask_for_wars
  # GET /ask_for_wars.json
  def index
    @ask_for_wars = AskForWar.all
  end

  # GET /ask_for_wars/1
  # GET /ask_for_wars/1.json
  def show
  end

  # GET /ask_for_wars/new
  def new
    @ask_for_war = AskForWar.new
  end

  # GET /ask_for_wars/1/edit
  def edit
  end

  # POST /ask_for_wars
  # POST /ask_for_wars.json
  def create
    @ask_for_war = AskForWar.new(ask_for_war_params)

    respond_to do |format|
      if @ask_for_war.save
        format.html { redirect_to @ask_for_war, notice: 'Ask for war was successfully created.' }
        format.json { render :show, status: :created, location: @ask_for_war }
      else
        format.html { render :new }
        format.json { render json: @ask_for_war.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ask_for_wars/1
  # PATCH/PUT /ask_for_wars/1.json
  def update
    respond_to do |format|
      if @ask_for_war.update(ask_for_war_params)
        format.html { redirect_to @ask_for_war, notice: 'Ask for war was successfully updated.' }
        format.json { render :show, status: :ok, location: @ask_for_war }
      else
        format.html { render :edit }
        format.json { render json: @ask_for_war.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ask_for_wars/1
  # DELETE /ask_for_wars/1.json
  def destroy
    @ask_for_war.destroy
    respond_to do |format|
      format.html { redirect_to ask_for_wars_url, notice: 'Ask for war was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ask_for_war
      @ask_for_war = AskForWar.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ask_for_war_params
      params.require(:ask_for_war).permit(:from_guild_id, :to_guild_id, :terms, :includes_ladder, :war_id, :status)
    end
end
