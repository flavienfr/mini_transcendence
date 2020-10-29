class WarTimesController < ApplicationController
  before_action :set_war_time, only: [:show, :edit, :update, :destroy]

  # GET /war_times
  # GET /war_times.json
  def index
    @war_times = WarTime.all
  end

  # GET /war_times/1
  # GET /war_times/1.json
  def show
  end

  # GET /war_times/new
  def new
    @war_time = WarTime.new
  end

  # GET /war_times/1/edit
  def edit
  end

  # POST /war_times
  # POST /war_times.json
  def create
    @war_time = WarTime.new(war_time_params)

    respond_to do |format|
      if @war_time.save
        format.html { redirect_to @war_time, notice: 'War time was successfully created.' }
        format.json { render :show, status: :created, location: @war_time }
      else
        format.html { render :new }
        format.json { render json: @war_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /war_times/1
  # PATCH/PUT /war_times/1.json
  def update
    respond_to do |format|
      if @war_time.update(war_time_params)
        format.html { redirect_to @war_time, notice: 'War time was successfully updated.' }
        format.json { render :show, status: :ok, location: @war_time }
      else
        format.html { render :edit }
        format.json { render json: @war_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /war_times/1
  # DELETE /war_times/1.json
  def destroy
    @war_time.destroy
    respond_to do |format|
      format.html { redirect_to war_times_url, notice: 'War time was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_war_time
      @war_time = WarTime.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def war_time_params
      params.require(:war_time).permit(:start_date, :end_date, :ongoing_match, :a, :b, :nb_unanswered_call_a, :nb_unanswered_call_b, :war_id, :status)
    end
end
