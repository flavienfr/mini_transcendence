require "uri"
require "net/http"
require "json"
    
class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.all
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
    puts "sessions/show params:", params
  end

  # GET /sessions/new
  def new
    @session = Session.new
  end

  # GET /sessions/1/edit
  def edit
  end

  # GET /sessions/oauth
  def oauth
    # see https://profile.intra.42.fr/oauth/applications
    
    puts "sessions/oauth params: ", params

    # if clicked on "nope"
    if (params.has_key?(:error))
      redirect_to root_path and return
    end

    # else if clicked on "nope"
    # --- Exchange your code for an access token
    puts "--- Exchange your code for an access token"

    header = {
        "grant_type" => ENV["oauth_grant_type"],
        "client_id" => ENV["oauth_client_id"],
        "client_secret" => ENV["oauth_client_secret"],
        "code" => params[:code],
        "redirect_uri" => ENV["oauth_redirect_uri"],
        "state" => ENV["oauth_state"]
    }

    begin
      res_access_token = Net::HTTP.post_form(URI.parse("https://api.intra.42.fr/oauth/token"), header)
      parsed_res_access_token = JSON.parse(res_access_token.body)

      puts "parsed_res_access_token: -", parsed_res_access_token, "-"

    rescue => e
      puts "error in 'Exchange your code for an access token':", e
      render json: e, status: :unprocessable_entity and return
    end

    # --- Create session
    # https://api.intra.42.fr/apidoc/guides/web_application_flow
    puts "--- Create session"
    session = Session.new(
      access_token: parsed_res_access_token["access_token"],
      token_type: parsed_res_access_token["token_type"],
      expires_in: parsed_res_access_token["expires_in"],
      refresh_token: parsed_res_access_token["refresh_token"],
      scope: parsed_res_access_token["scope"],
      created_at: parsed_res_access_token["created_at"]
    )
    puts "session:", session

    # --- Make API requests with token
    # https://stackoverflow.com/questions/34332901/rails-http-get-request-with-no-ssl-verification-and-basic-auth
    puts "--- Make API requests with token"
    begin
      uri = URI.parse("https://api.intra.42.fr/v2/me/")
      req_api = Net::HTTP::Get.new(uri)
      req_api['Authorization'] = "Bearer #{session.access_token}"
      sock = Net::HTTP.new(uri.host, uri.port)
      sock.use_ssl = true
      res_api = sock.start { |http| http.request(req_api) }
      parsed_res_api = JSON.parse(res_api.body)
      puts "parsed_res_api:", parsed_res_api
    rescue => e
      puts "error in 'Make API requests with your token':", e
      render json: e, status: :unprocessable_entity and return
    end

    # --- Find user or create it
    # https://stackoverflow.com/questions/5733222/rails-how-to-use-find-or-create
    nb_user = User.where("student_id = ?", parsed_res_api["id"].to_i).size
    # puts "nb_user:", nb_user
    if nb_user > 1
      render json: e, status: :unprocessable_entity and return
    elsif nb_user == 1
      user = User.where("student_id = ?", parsed_res_api["id"].to_i).first
      if user.current_status == "logged in"
        cookies.delete :id
        session = user.sessions.last
        if session
          session.destroy
        end
        user.current_status = "offline"
        user.save
        redirect_to root_path and return
      end
      user.update(
        current_status: "logged in",
        is_admin: true
      )
    else
      user = User.new(
        student_id: parsed_res_api["id"].to_i,
        name: parsed_res_api["displayname"],
        current_status: "logged in",
        enabled_two_factor_auth: false,
        is_admin: false,
        is_owner: false
      )
      # --- Upload user image to cloudinary
      # https://github.com/cloudinary/cloudinary_gem
      require 'open-uri'
      begin
        filename = "#{user.student_id.to_s}.jpg"
        # puts "filename: " + filename.to_s
        # puts "trying to open: " + parsed_res_api["image_url"].to_s
        file = URI.open(parsed_res_api["image_url"].to_s)
        # puts "ok file open"
        ret = user.photo.attach(io: file, filename: filename, content_type: 'image/jpg')
        puts "ret:", ret
        puts user.photo.attached?
        user.avatar = Cloudinary::Utils.cloudinary_url(user.photo.key)
      rescue => e
        puts "error in 'Upload user image to cloudinary':", e
        render json: e, status: :internal_server_error and return
      end
    end
    user.save
    puts "user:", user.inspect

    # --- 2 factor auth
    if user.enabled_two_factor_auth == true
      session.need_two_factor_auth_validation = true
    end

    # --- Link newly created session to user
    session.user_id = user.id
    session.save
    
    # --- Set cookie
    cookies.permanent.signed[:id] = session.user_id

    # --- Render
    redirect_to root_path and return
  end

  # POST /sessions/1/validation
  def validation
    # set_session
    @session = Session.find(params[:id])

    puts 'sessions/', @session.id.to_s, '/validation params: ', params

    user = @session.user
    ret = user.authenticate_otp(params[:code])
    puts 'sessions/', @session.id.to_s, '/validation ret: ', ret
    
    if (ret != nil)
      @session.need_two_factor_auth_validation = false;
      @session.save
      render json: {}, status: :ok and return
    else
      render json: {}, status: :unauthorized and return
    end

  end

  # POST /sessions
  # POST /sessions.json
  def create
    @session = Session.new(session_params)

    if @session.save
      format.json { render json: @session, status: ok } # ok -> 200
    else
      format.json { render json: @session.errors, status: :unprocessable_entity } # ok -> 422
    end

  end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { render :show, status: :ok, location: @session }
      else
        format.html { render :edit }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    # récupérer la session du user
    session = Session.find(params[:id])
    # mettre le status du user en offline
    user = session.user
    user.current_status = "offline"
    user.save
    # supprimer la session
    session.destroy    
    # supprimer le cookie
    hashed_cookies = cookies.to_hash
    puts "DELETE /sessions/", params[:id].to_s, " -> hashed_cookies AVANT supprimer de l'id:", hashed_cookies    
    cookies.delete :id
    hashed_cookies = cookies.to_hash
    puts "DELETE /sessions/", params[:id].to_s, " -> hashed_cookies APRES supprimer de l'id:", hashed_cookies
    # render ok 200
    render json: {}, status: :ok and return
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def session_params
      params.require(:session).permit(:token, :timeout, :user_id)
    end

end
