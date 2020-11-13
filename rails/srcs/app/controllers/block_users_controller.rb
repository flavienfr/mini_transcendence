class BlockUsersController < ApplicationController
  before_action :set_block_user, only: [:show, :edit, :update, :destroy]

  # GET /block_users
  # GET /block_users.json
  def index
    puts params;
    # @block_users = BlockUser.all
    if (params[:type] == "find")
      respond_to do |format|
        format.html
        format.json {render json: BlockUser.where("user_id = ? AND block_user_id = ?", params[:user_id], params[:block_user_id]).first}
      end
    else
      blocked_users = User.find_by(id: params[:user_id]).block_users;
      ordered_blocked_users = {};
      blocked_users.each do |block_user|
        ordered_blocked_users[block_user.block_user_id] = "blocked";
      end
      respond_to do |format|
        format.html
        format.json {render json: ordered_blocked_users}
      end
    end
  end

  # GET /block_users/1
  # GET /block_users/1.json
  def show
  end

  # GET /block_users/new
  def new
    @block_user = BlockUser.new
  end

  # GET /block_users/1/edit
  def edit
  end

  # POST /block_users
  # POST /block_users.json
  def create
    @block_user = BlockUser.new(block_user_params)

    respond_to do |format|
      if @block_user.save
        format.html { redirect_to @block_user, notice: 'Block user was successfully created.' }
        format.json { render :show, status: :created, location: @block_user }
      else
        format.html { render :new }
        format.json { render json: @block_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /block_users/1
  # PATCH/PUT /block_users/1.json
  def update
    respond_to do |format|
      if @block_user.update(block_user_params)
        format.html { redirect_to @block_user, notice: 'Block user was successfully updated.' }
        format.json { render :show, status: :ok, location: @block_user }
      else
        format.html { render :edit }
        format.json { render json: @block_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /block_users/1
  # DELETE /block_users/1.json
  def destroy
    @block_user.destroy
    respond_to do |format|
      format.html { redirect_to block_users_url, notice: 'Block user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_block_user
      @block_user = BlockUser.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def block_user_params
      params.require(:block_user).permit(:user_id, :block_user_id, :status)
    end
end
