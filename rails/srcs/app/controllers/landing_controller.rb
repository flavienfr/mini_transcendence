class LandingController < ApplicationController

# @@current_user = 0

  def index
      if (current_user)
        @users = User.all
        puts "------------a-----------"
        @joignable_groups = Channel.where("scope = ? OR scope = ?", "public-group", "protected-group");
        puts @joignable_groups.to_json;
        @channel_participations = User.find_by(id: current_user.id).channel_participations;
        puts @channel_participations.to_json;
        @joignable_groups = @joignable_groups.where.not("id IN (?)", @channel_participations.pluck(:channel_id));
        puts @joignable_groups.to_json;#a utiliser
        @private_channels = Channel.where("scope = ?", "private-direct");
        puts @private_channels.to_json;
        @channel_participations = @channel_participations.where.not("channel_id IN (?)", @private_channels.pluck(:id));
        puts @channel_participations.to_json;
        @in_channels = Channel.where("id IN (?)", @channel_participations.pluck(:channel_id));
        puts @in_channels.to_json;#a utiliser
        puts "---------b---------"
      end
    
    # puts params.inspect

    # auth
    
      # puts @current_user
    # @current_user = @@current_user
    # @@current_user
    if (params[:code])
      auth(params[:code])
    end

  end

  def update
  end


  def create
  end

  private
  
    def auth_params
      params.require(:landing).permit(:code, :state)
    end

    def auth(code)

      #puts "code:", code

      # see https://profile.intra.42.fr/oauth/applications

      #puts "\n 1) Exchange your code for an access token --------------\n"
      # --- Exchange your code for an access token
      require "uri"
      require "net/http"
      require "json"

      #puts ENV["oauth_grant_type"]
      #puts ENV["oauth_client_id"]
      #puts ENV["oauth_client_secret"]
      #puts ENV["oauth_redirect_uri"]
      #puts ENV["oauth_state"]
      header = {
          "grant_type" => ENV["oauth_grant_type"],
          "client_id" => ENV["oauth_client_id"],
          "client_secret" => ENV["oauth_client_secret"],
          "code" => code,
          "redirect_uri" => ENV["oauth_redirect_uri"],
          "state" => ENV["oauth_state"]
      }
      res_access_token = Net::HTTP.post_form(URI.parse("https://api.intra.42.fr/oauth/token"), header)
      parsed_res_access_token = JSON.parse(res_access_token.body)
      puts parsed_res_access_token

      # Session.delete_all
      # User.delete_all

      # --- Create session
      session = Session.new(
        access_token: parsed_res_access_token["access_token"],
        token_type: parsed_res_access_token["token_type"],
        expires_in: parsed_res_access_token["expires_in"],
        refresh_token: parsed_res_access_token["refresh_token"],
        scope: parsed_res_access_token["scope"],
        created_at: parsed_res_access_token["created_at"]
      )

      #puts session.to_yaml

      #puts "\n 2) Make API requests with your token --------------\n"
      # --- Make API requests with your token
      # https://stackoverflow.com/questions/34332901/rails-http-get-request-with-no-ssl-verification-and-basic-auth

      uri = URI.parse("https://api.intra.42.fr/v2/me/")
      req_api = Net::HTTP::Get.new(uri)
      req_api['Authorization'] = "Bearer #{session.access_token}"
      # req_api['Authorization'] = "Bearer 1be46342256b793c5642db9e9942de8747b0d0cbc12ec5ad913fd0f3687a85a9"
      sock = Net::HTTP.new(uri.host, uri.port)
      sock.use_ssl = true
      res_api = sock.start { |http| http.request(req_api) }

      parsed_res_api = JSON.parse(res_api.body)
      #puts parsed_res_api

      if User.where(name: parsed_res_api["displayname"]).exists?
        session.user_id = User.find_by(name: parsed_res_api["displayname"]).id
        # session[:user_id] = User.find_by(name: parsed_res_api["displayname"]).id
        cookies.permanent.signed[:id] = session.user_id
        session.save
      else
        user = User.create(
          name: parsed_res_api["displayname"],
          avatar: parsed_res_api["image_url"],
          current_status: "logged in",
          points: 0,
          is_admin: false
        )
        session.user_id = user.id
        cookies.permanent.signed[:id] = session.user_id
        # session[:user_id] = user.id
        session.save
      end
      # @@current_user = session.user_id

    if (params[:code])
      
      #puts user.to_yaml

      # ocker-compose run web rails console -> to see if it worked
      redirect_to root_path # à enlever pcq ça reload la page

    end
  end
end
