class WatchesController < ApplicationController
  before_action :set_watch, only: [:show, :edit, :update, :destroy]

  # GET /watches
  # GET /watches.json
  def index
    if (params[:user_id])
      @watches = Watch.find_by(user_id: params[:user_id])
        if (@watches == nil)
          @watches = Watch.new(user_id: params[:user_id], hostId: 0)
          @watches.save
        end
      respond_to do |format|
        format.html
        format.json {render json: @watches}
      end
    end
  end

  # GET /watches/1
  # GET /watches/1.json
  def show
    puts "je suis ici !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  end

  # GET /watches/new
  def new
    @watch = Watch.new
  end

  # GET /watches/1/edit
  def edit
  end

  # POST /watches
  # POST /watches.json
  def create
    @watch = Watch.new(watch_params)

    respond_to do |format|
      if @watch.save
        format.html { redirect_to @watch, notice: 'Watch was successfully created.' }
        format.json { render :show, status: :created, location: @watch }
      else
        format.html { render :new }
        format.json { render json: @watch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /watches/1
  # PATCH/PUT /watches/1.json
  def update
    respond_to do |format|
      if @watch.update(watch_params)
        format.html { redirect_to @watch, notice: 'Watch was successfully updated.' }
        format.json { render :show, status: :ok, location: @watch }
      else
        format.html { render :edit }
        format.json { render json: @watch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /watches/1
  # DELETE /watches/1.json
  def destroy
    @watch.destroy
    respond_to do |format|
      format.html { redirect_to watches_url, notice: 'Watch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_watch
      @watch = Watch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def watch_params
      params.require(:watch).permit(:hostId, :user_id)
    end
end
