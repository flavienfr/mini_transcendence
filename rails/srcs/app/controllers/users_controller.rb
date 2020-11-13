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
    puts 'inside update | PUT /users/:id'
    puts 'params: ', params

    render json: @user
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

    if (params[:type] == "admin_update")
      @user.update(user_params)
      return;
    end
    
    puts 'inside update | PUT /users/:id'
    puts 'params: ', params
    puts '---'

    begin
      puts "trying to read file"
      file = params[:avatar].tempfile.read.force_encoding("UTF-8")
      puts "ok read file"
      data = JSON.parse(file)
      # render json: data
    rescue
        render json: { errors: 'Upload failed' }
    end

    File.write "#{user.student_id.to_s}.jpg", open(params[:avatar]).read.force_encoding("UTF-8")
    puts "ok file write"
    require 'cloudinary'
    cloudinary_res = Cloudinary::Uploader.upload(
      "#{user.student_id.to_s}.jpg",
      {
        cloud_name: ENV["cloudinary_Cloud_name"],
        api_key: ENV["cloudinary_API_Key"],
        api_secret: ENV["cloudinary_API_Secret"]
      }
    )
    File.delete(Rails.root.to_s + "/#{user.student_id.to_s}.jpg")
    puts 'cloudinary_res:', cloudinary_res
    # puts 'cloudinary_res["url"]:', cloudinary_res["url"]
    user.avatar = cloudinary_res["url"]

    if @user.update(
      name: params[:name],
      # avatar: params[:avatar],
      enabled_two_factor_auth: params[:enabled_two_factor_auth]
    )
      render json: {}, status: :ok and return
    else
      render json: @user.errors, status: :unprocessable_entity and return
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
      params.require(:user).permit(:name, :avatar, :current_status, :points, :is_admin, :enabled_two_factor_auth)
    end

  end
