class UserTitlesController < ApplicationController
  before_action :set_user_title, only: [:show, :edit, :update, :destroy]

  # GET /user_titles
  # GET /user_titles.json
  def index
    @user_titles = UserTitle.all
  end

  # GET /user_titles/1
  # GET /user_titles/1.json
  def show
  end

  # GET /user_titles/new
  def new
    @user_title = UserTitle.new
  end

  # GET /user_titles/1/edit
  def edit
  end

  # POST /user_titles
  # POST /user_titles.json
  def create
    @user_title = UserTitle.new(user_title_params)

    respond_to do |format|
      if @user_title.save
        format.html { redirect_to @user_title, notice: 'User title was successfully created.' }
        format.json { render :show, status: :created, location: @user_title }
      else
        format.html { render :new }
        format.json { render json: @user_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_titles/1
  # PATCH/PUT /user_titles/1.json
  def update
    respond_to do |format|
      if @user_title.update(user_title_params)
        format.html { redirect_to @user_title, notice: 'User title was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_title }
      else
        format.html { render :edit }
        format.json { render json: @user_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_titles/1
  # DELETE /user_titles/1.json
  def destroy
    @user_title.destroy
    respond_to do |format|
      format.html { redirect_to user_titles_url, notice: 'User title was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_title
      @user_title = UserTitle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_title_params
      params.require(:user_title).permit(:user_id_id, :tournament_id, :title, :status)
    end
end
