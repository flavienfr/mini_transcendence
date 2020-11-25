class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :edit, :update, :destroy]

  # GET /friendships
  # GET /friendships.json
  def index
    @friendships = Friendship.all 
    # friendships_ids = Friendship.all
    # .where('sender_id = ? or recipient_id = ?', params[:id].to_i, params[:id].to_i)
    # .pluck(:sender_id, :recipient_id)
    # .uniq().flatten()

    # friendships_ids.delete(params[:id].to_i) 
    # @users = User.where("id IN (?)", friendships_ids)
    render json: User.find(params[:id].to_i).get_friendships("active").as_json
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
  end

  # GET /friendships/new
  def new
    @friendship = Friendship.new
  end

  # GET /friendships/1/edit
  def edit
  end

  # POST /friendships
  # POST /friendships.json
  def create
    @friendship = Friendship.new(friendship_params)



    respond_to do |format|

      if (Friendship.where('sender_id=? AND recipient_id=?', 
       @friendship.sender_id, @friendship.recipient_id).size > 0)
        puts "ICICICICICI"
        format.html { render :new }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      elsif (Friendship.where('sender_id=? AND recipient_id=?', 
       @friendship.recipient_id, @friendship.sender_id).size > 0)
        puts "LALALALALA"
        format.html { render :new }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      elsif @friendship.save
        format.html { redirect_to @friendship, notice: 'Friendship was successfully created.' }
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :new }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friendships/1
  # PATCH/PUT /friendships/1.json
  def update
    respond_to do |format|
      if @friendship.update(friendship_params)
        format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
        format.json { render :show, status: :ok, location: @friendship }
      else
        format.html { render :edit }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to friendships_url, notice: 'Friendship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.require(:friendship).permit(:status, :sender_id, :recipient_id)
    end
end
