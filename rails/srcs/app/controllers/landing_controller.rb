class LandingController < ApplicationController

  def index
    @users = User.all
    puts params.inspect
    # pry
    if (params[:code])
      puts "\nok\n"
      puts params[:code]

      # https://profile.intra.42.fr/oauth/applications

      puts "\n--------------\n"

      # --- Exchange your code for an access token
      require "uri"
      require "net/http"
      require "json"

      header = {
          "grant_type" => "authorization_code",
          "client_id" => "235a071025e8e19cdd302e0cff45e29c2b7c2a8b1fd37bc7cdbf4e2edc452729",
          "client_secret" => "bd247fc761561f68598d981c4c151e43905690f9a8f99039631e5a6b1098a2dc",
          "code" => params[:code],
          "redirect_uri" => "http://localhost:3000/",
          "state" => "a_very_long_random_string_witchmust_be_unguessable"
      }
      response = Net::HTTP.post_form(URI.parse("https://api.intra.42.fr/oauth/token"), header)

      puts response
      puts response.body

      
      puts "\n--------------\n"


      # --- Make API requests with your token
      puts response.body.class
      parsed_response = JSON.parse(response.body)
      puts parsed_response["access_token"]

      uri = URI.parse("https://api.intra.42.fr/v2/me")
      req = Net::HTTP::Get.new(uri.path)
      req['Authorization'] = "Bearer #{parsed_response["access_token"]}"
      
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      res = http.get(uri.request_uri)

      puts res.body

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

  end
