class WarsController < ApplicationController
  before_action :set_war, only: [:show, :edit, :update, :destroy]

  # GET /wars
  # GET /wars.json
  def index
	@wars = Guild.find(params[:guild_id].to_i).wars.order(start_date: 'desc')
	@wars = @wars.where('wars.status = ?', "ending")
	#@wars = War.all
	puts "------------------------------------------"
	puts "@wars= ", @wars.to_json
  end

  # GET /wars/1
  # GET /wars/1.json
  def show
  end

  # GET /wars/new
  def new
    @war = War.new
  end

  # GET /wars/1/edit
  def edit
  end

  # POST /wars
  # POST /wars.json
  def create
    @war = War.new(war_params)

    respond_to do |format|
      if @war.save
        format.html { redirect_to @war, notice: 'War was successfully created.' }
        format.json { render :show, status: :created, location: @war }
      else
        format.html { render :new }
        format.json { render json: @war.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wars/1
  # PATCH/PUT /wars/1.json
  def update
    respond_to do |format|
      if @war.update(war_params)
        format.html { redirect_to @war, notice: 'War was successfully updated.' }
        format.json { render :show, status: :ok, location: @war }
      else
        format.html { render :edit }
        format.json { render json: @war.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wars/1
  # DELETE /wars/1.json
  def destroy
    @war.destroy
    respond_to do |format|
      format.html { redirect_to wars_url, notice: 'War was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_war
      @war = War.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def war_params
      params.require(:war).permit(:start_date, :end_date, :prize_in_points, :max_unanswered_call, :winner_id, :status)
    end
end
