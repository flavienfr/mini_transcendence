class UsersController < ApplicationController
  before_action :set_user, only: [:show, :profile, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    puts params;
    @users = User.all
    if (params[:user_id] && params[:type] == "viewer")
      @users = User.find(params[:user_id]);
      puts(@users.name);
      respond_to do |format|
        format.html
        format.json { render json: @users}
      end
    elsif (params[:users_to_get] == "participants")
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
    else
      respond_to do |format|
        format.html
        format.json {render json: User.all}
      end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    puts 'inside SHOW | GET /users/:id'
    puts 'params: ', params

    render json: @user
  end

  # GET /users/1/profile
  def profile
    puts 'inside GET /users/:id/profile'
    puts 'params: ', params
    @target_user = User.find(params[:target_user_id])
    
    if (@target_user)
      render json: {
        "data": {
          "current_user": @user.as_json,
          "target_user": @target_user.as_json,
          "guild": @target_user.guilds.last.as_json,
          "match_history": @target_user.get_match_history("played").as_json,
          "friends": @target_user.get_friendships("active").as_json  
        }
      }, status: :ok and return
    else
      render json: { data: { "error": "target user not found" } }, status: :unprocessable_entity and return
    end
  end

  # GET /users/google_authenticator_qr_code
  def google_authenticator
    app_name = "Transcendence"
    @qr = RQRCode::QRCode.new(current_user.provisioning_uri(app_name), :size => app_name.size, :level => :h )
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
    
    puts 'inside update | PUT /users/:id'
    puts 'params: ', params
    puts '---'

    if (params[:type] == "admin_update")
      @user.update(user_params)
      return;
    end

    
    render json: { }, status: :unauthorized and return if User.find(params[:id]).id != current_user.id

    # parse params: name / photo / enabled_two_factor_auth
    update_params = {} # hash
    # - name
    if (params.has_key?(:name))
      update_params["name"] = params[:name]
    end
    # - photo
    if (params.has_key?(:photo))
      file = params[:photo].open
      puts 'file', file
      puts '---'
      img_name = "#{@user.student_id.to_s}.jpg"
      @user.photo.attach(io: file, filename: img_name, content_type: 'image/jpg')
      update_params["avatar"] = Cloudinary::Utils.cloudinary_url(@user.photo.key)
    end
    # - enabled_two_factor_auth
    if (params.has_key?(:enabled_two_factor_auth))
      two_factor_auth = (params[:enabled_two_factor_auth] == "true" ? true : false)
      update_params["enabled_two_factor_auth"] = two_factor_auth
    end
    # - current_status
    if (params.has_key?(:current_status))
      update_params["current_status"] = params[:current_status]
    end

    # - current_status
    if (params.has_key?(:current_status))
      update_params["current_status"] = params[:current_status]
      ActionCable.server.broadcast("player_channel", {current_status: "On"})
    end

    if @user.update(update_params)
      render json: { data: @user.as_json }, status: :ok and return
    else
      render json: { data: @user.errors.as_json }, status: :unprocessable_entity and return
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
      params.require(:user).permit(:name, :avatar, :current_status, :points, :is_admin, :enabled_two_factor_auth, :photo)
    end

  end
