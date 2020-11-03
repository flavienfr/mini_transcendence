class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  # GET /notifications
  # GET /notifications.json
  def index
    # @notifications = Notification.all
    @notification = Notification.where('user_id = ?', current_user.id)
    render json: @notification
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
     puts "__________________________________"
     puts @notification
     puts "__________________________________"
  end

  # GET /notifications/new
  def new
   
  end

  # GET /notifications/1/edit
  def edit
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(notification_params)

    # ------->  A changer (mettre la ligne commenter a la place de l'autre)
    # notif_channel = "notification_channel_" + @notification.from_user_id.to_s;
    notif_channel = "notification_channel_" + @notification.user_id.to_s;

    ActionCable.server.broadcast(notif_channel, {notification: "On"})
    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render :show, status: :created, location: @notification }
      else
        format.html { render :new }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
      end
  end

  # PATCH/PUT /notifications/1
  # PATCH/PUT /notifications/1.json
  def update
    respond_to do |format|
      if @notification.update(notification_params)
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { render :show, status: :ok, location: @notification }
      else
        format.html { render :edit }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notification_params
      params.require(:notification).permit(:from_user_id, :user_id, :to_channel_id, :to_guild_id, :type, :message, :status)
    end
end
