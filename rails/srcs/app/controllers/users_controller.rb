class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    puts params;
    @users = User.all
    if (params[:users_to_get] == "participants")
      channel_participations = Channel.find_by(id: params[:channel_id]).channel_participations;
      channel_participations_banned = channel_participations.where("status = 'banned'");
      if (channel_participations_banned.size > 0)
        channel_participations = channel_participations.where.not("id IN (?)", channel_participations_banned.pluck(:id));
      end
      @users_in = User.where("id IN (?)", channel_participations.pluck(:user_id));
      respond_to do |format|
        format.html
        format.json { render json: @users_in}
      end
    elsif (params[:users_to_get] == "not_participants")
      participants = Channel.find_by(id: params[:channel_id]).channel_participations;
      @users_not_in = @users;
      if (participants.size > 0)
        @users_not_in = @users.where.not("id IN (?)", participants.pluck(:user_id));
      end
      respond_to do |format|
        format.html
        format.json { render json: @users_not_in}
      end
    elsif (params[:users_to_get] == "banned_participants")
      participants = Channel.find_by(id: params[:channel_id]).channel_participations;
      banned_participants = participants.where("status = 'banned'");
      users_banned = @users.where("id IN (?)", banned_participants.pluck(:user_id));
      respond_to do |format|
        format.html
        format.json {render json: users_banned}
      end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :avatar, :current_status, :points, :is_admin)
    end

    def auth_params
      params.require(:user).permit(:code, :state)
    end
  end
