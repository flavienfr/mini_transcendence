rails g scaffold user name:string avatar:string points:integer is_admin:boolean guild_participation:references is_playing:boolean otp_secret_key:string enabled_two_factor_auth:boolean student_id:integer status:string

rails g scaffold session user:references access_token:string timeout:datetime token_type:string refresh_token:string scope:string need_two_factor_auth_validation:boolean status:string

rails g scaffold guild name:string anagram:string points:integer is_making_war:boolean owner_id:integer war_participation:references status:string
rails g scaffold guild_participation user:references guild:references is_admin:boolean is_officer:boolean status:string

rails g scaffold achievement name:string description:string points:integer status:string
rails g scaffold user_achievement user:references achievement:references status:string

rails g scaffold friendship status:string
rails g scaffold ask_for_friendship friendship:references status:string

rails g scaffold channel name:string scope:string password:string owner_id:integer status:string
rails g scaffold channel_participation user:references channel:references is_owner:boolean is_winner:boolean status:string
rails g scaffold message user:references channel:references text:string status:string

rails g scaffold war start_date:datetime end_date:datetime prize_in_points:integer max_unanswered_call:integer winner_id:integer is_war_time:boolean status:string
rails g scaffold ask_for_war from_guild_id:integer to_guild_id:integer terms:text includes_ladder:boolean war:references count_all_matchs_for_war:boolean status:string
rails g scaffold war_participation guild:references war:references has_declared_war:boolean war_points:integer nb_unanswered_call:integer is_winner:boolean status:string 
rails g scaffold war_time war:references start_date:datetime end_date:datetime ongoing_match:boolean a:integer b:integer nb_unanswered_call_a:integer nb_unanswered_call_b:integer status:string

rails g scaffold tournament deadline:datetime type:string rules:string incentives:string max_nb_player:integer status:string
rails g scaffold tournament_participation user:references tournament:references score:integer nb_won_game:integer nb_lost_game:integer status:string

rails g scaffold game start_date:datetime end_date:datetime context:string channel:references war:references war_time:references tournament:references winner_id:integer status:string
rails g scaffold game_participation user:references game:references score:integer is_winner:boolean status:string
rails g scaffold ask_for_game from_user_id:integer to_user_id:integer game:references status:string

rails g scaffold notification from_user_id:integer user:references to_channel_id:integer to_guild_id:integer table_type:string message:string status:string table_id:integer

rails g scaffold block_user user_id:references block_user_id:integer status:string

rails g scaffold user_title user_id:references tournament_id:references title:string status:string

# rails generate migration add_fieldname_to_tablename fieldname:string
# rails generate migration add_is_owner_to_user is_owner:boolean
# rails generate migration add_status_to_game_participations status:string
# rails g migration ChangeAskForFriendships
# rails generate migration add_fieldname_to_tablename fieldname:string
# rails g migration add_count_all_matchs_for_war_to_war count_all_matchs_for_war:boolean
# rails generate migration add_user_title_id_to_users user_title_id:integer
