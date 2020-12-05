# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# destroy all objects

ActiveRecord::Base.connection.disable_referential_integrity do
    puts "----- TournamentParticipation.destroy_all"
    TournamentParticipation.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('tournament_participations') # to reset id back to 1

    puts "----- Title.destroy_all"
    Title.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('titles') # to reset id back to 1

    puts "----- Tournament.destroy_all"
    Tournament.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('tournaments') # to reset id back to 1

    puts "----- AskForWar.destroy_all"
    AskForWar.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('ask_for_wars') # to reset id back to 1

    puts "----- WarParticipation.destroy_all"
    WarParticipation.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('war_participations') # to reset id back to 1

    puts "----- WarTime.destroy_all"
    WarTime.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('war_times') # to reset id back to 1

    puts "----- War.destroy_all"
    War.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('wars') # to reset id back to 1

    puts "----- Message.destroy_all"
    Message.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('messages') # to reset id back to 1

    puts "----- ChannelParticipation.destroy_all"
    ChannelParticipation.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('channel_participations') # to reset id back to 1

    puts "----- Channel.destroy_all"
    Channel.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('channels') # to reset id back to 1

    puts "----- GuildParticipation.destroy_all"
    GuildParticipation.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('guild_participations') # to reset id back to 1

    puts "----- Guild.destroy_all"
    Guild.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('guilds') # to reset id back to 1

    puts "----- AskForGame.destroy_all"
    AskForGame.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('ask_for_games') # to reset id back to 1

    puts "----- GameParticipation.destroy_all"
    GameParticipation.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('game_participations') # to reset id back to 1

    puts "----- game.destroy_all"
    Game.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('games') # to reset id back to 1

    puts "----- Friendship.destroy_all"
    Friendship.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('friendships') # to reset id back to 1

    puts "----- AskForFriendship.destroy_all"
    AskForFriendship.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('ask_for_friendships') # to reset id back to 1

    puts "----- Session.destroy_all"
    Session.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('sessions') # to reset id back to 1

    puts "----- Notification.destroy_all"
    Notification.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('notifications') # to reset id back to 1

    puts "----- User.destroy_all"
    User.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('users') # to reset id back to 1
end

## users
# fake
angela_merkel = User.create(name: "Angela Merkel", avatar: "https://cdn.radiofrance.fr/s3/cruiser-production/2016/11/8214f25e-188a-4b11-a7eb-fd255ebe08aa/838_000_i965n.jpg", current_status: "offline", points: 45, is_admin: false, is_owner: false, guild_participation_id: nil, enabled_two_factor_auth: true) 
elon_musk = User.create(name: "Elon Musk", avatar: "https://cdn.futura-sciences.com/buildsv6/images/largeoriginal/d/9/a/d9a1058910_50163142_elon-musk1.jpg", current_status: "offline", points: 99, is_admin: false, is_owner: false, guild_participation_id: nil)
xavier_niel = User.create(name: "Xavier Niel", avatar: "https://www.challenges.fr/assets/img/2018/05/23/cover-r4x3w1000-5b572372b44c2-xavier-niel-transfere-l-essentiel-de-ses-parts-d-iliad-a.jpg", current_status: "offline", points: 100, is_admin: false, is_owner: false, guild_participation_id: nil)
# pape_francois = User.create(name: "Pape Francois", avatar: "https://www.biography.com/.image/t_share/MTE1ODA0OTcyMDMzNTQxNjQ1/pope-francis-21152349-2-402.jpg", current_status: "offline", points: 33, is_admin: false, is_owner: false, guild_participation_id: nil) 
# feca = User.create(name: "Feca feu", avatar: "https://pre.breakflip.com/uploads/Dofus/Feca/Feca_male.png", current_status: "offline", points: 1, is_admin: false, is_owner: false, guild_participation_id: nil) 
# kebab = User.create(name: "Salade Tomate Oignon", avatar: "https://static.lexpress.fr/medias_11842/w_1000,c_fill,g_north/kebab-antalya_6063300.jpeg", current_status: "offline", points: 1, is_admin: false, is_owner: false, guild_participation_id: nil) 
# team
fberger = User.create(student_id: 37271, name: "Francis", avatar: "https://res.cloudinary.com/dwcxgy6qt/image/upload/q7jfqa4cd4q8xpnxmoz55sbmi1py", current_status: "offline", points: 36, is_admin: true, is_owner: false, guild_participation_id: nil)
maxime = User.create(student_id: 55895, name: "Maxime", avatar: "https://cdn.intra.42.fr/users/medium_mpouzol.jpg", current_status: "offline", points: 63, is_admin: true, is_owner: true, guild_participation_id: nil)
flavien = User.create(student_id: 58251, name: "Flavien", avatar: "https://cdn.intra.42.fr/users/medium_froussel.jpg", current_status: "offline", points: 56, is_admin: true, is_owner: true, guild_participation_id: nil)
puts "----- Users created"

## sessions
# 


## ask_for_friendship
# angela_merkel
aff_dt_1 = AskForFriendship.new(sender_id: angela_merkel.id, recipient_id: elon_musk.id, status: "active")
aff_dt_2 = AskForFriendship.new(sender_id: angela_merkel.id, recipient_id: xavier_niel.id, status: "active")
# aff_dt_3 = AskForFriendship.new(sender_id: angela_merkel.id, recipient_id: pape_francois.id, status: "active")
# aff_dt_4 = AskForFriendship.new(sender_id: angela_merkel.id, recipient_id: feca.id, status: "active")
# aff_dt_5 = AskForFriendship.new(sender_id: angela_merkel.id, recipient_id: kebab.id, status: "active")
# maxime
aff_mp_1 = AskForFriendship.new(sender_id: angela_merkel.id, recipient_id: elon_musk.id, status: "active")
aff_mp_2 = AskForFriendship.new(sender_id: angela_merkel.id, recipient_id: xavier_niel.id, status: "active")
# aff_mp_3 = AskForFriendship.new(sender_id: angela_merkel.id, recipient_id: pape_francois.id, status: "active")
# aff_mp_4 = AskForFriendship.new(sender_id: angela_merkel.id, recipient_id: feca.id, status: "active")
# aff_mp_5 = AskForFriendship.new(sender_id: angela_merkel.id, recipient_id: kebab.id, status: "active")
puts "----- AskForFriendship initialized"

## friendship
# angela_merkel
f1 = Friendship.create(sender_id: angela_merkel.id, recipient_id: elon_musk.id, status: "active")
aff_dt_1.friendship_id = f1.id
aff_dt_1.save
f2 = Friendship.create(sender_id: angela_merkel.id, recipient_id: xavier_niel.id, status: "active")
aff_dt_2.friendship_id = f2.id
aff_dt_2.save
# f3 = Friendship.create(sender_id: angela_merkel.id, recipient_id: pape_francois.id, status: "active")
# aff_dt_3.friendship_id = f3.id
# aff_dt_3.save
# f4 = Friendship.create(sender_id: angela_merkel.id, recipient_id: feca.id,  status: "active")
aff_dt_4.friendship_id = f4.id
aff_dt_4.save
# f5 = Friendship.create(sender_id: angela_merkel.id, recipient_id: kebab.id,  status: "active")
aff_dt_5.friendship_id = f5.id
aff_dt_5.save
# maxime
f6 = Friendship.create(sender_id: maxime.id, recipient_id: elon_musk.id, status: "active")
aff_mp_1.friendship_id = f6.id
aff_mp_1.save
f7 = Friendship.create(sender_id: maxime.id, recipient_id: xavier_niel.id, status: "active")
aff_mp_2.friendship_id = f7.id
aff_mp_2.save
# f8 = Friendship.create(sender_id: maxime.id, recipient_id: pape_francois.id, status: "active")
# aff_mp_3.friendship_id = f8.id
# aff_mp_3.save
f9 = Friendship.create(sender_id: maxime.id, recipient_id: angela_merkel.id,  status: "active")
aff_mp_4.friendship_id = f9.id
aff_mp_4.save
# f10 = Friendship.create(sender_id: maxime.id, recipient_id: kebab.id,  status: "active")
aff_mp_5.friendship_id = f10.id
aff_mp_5.save
puts "----- Friendship created"


## guilds
assemblee = Guild.create(name: "The Assembly", anagram: "42", points: 339, is_making_war: false ,owner_id: angela_merkel.id)
order     = Guild.create(name: "The Order",    anagram: "42", points: 227, is_making_war: false, owner_id: elon_musk.id  )
puts "----- Guilds created"

## guild participations
# the Assemblee
ap1 = GuildParticipation.create(user_id: angela_merkel.id, guild_id: assemblee.id, is_admin: true, is_officer: false)
angela_merkel.guild_participation_id = ap1.id
angela_merkel.save
#
ap2 = GuildParticipation.create(user_id: xavier_niel.id, guild_id: assemblee.id, is_admin: false, is_officer: true)
xavier_niel.guild_participation_id = ap2.id
xavier_niel.save

# the Order
op1 = GuildParticipation.create(user_id: elon_musk.id, guild_id: order.id, is_admin: true, is_officer: false)
elon_musk.guild_participation_id = op1.id
elon_musk.save
#
# op2 = GuildParticipation.create(user_id: pape_francois.id, guild_id: order.id, is_admin: false, is_officer: true)
# pape_francois.guild_participation_id = op2.id
# pape_francois.save
#
# op3 = GuildParticipation.create(user_id: feca.id, guild_id: order.id, is_admin: false, is_officer: true)
# feca.guild_participation_id = op3.id
# feca.save
puts "----- Guild Participations created"


## games for fberger / xavier_niel
gm1 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm2 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm3 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm4 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm5 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm6 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm7 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")

# games for maxime / pape_francois
# gm8 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: pape_francois.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
# gm9 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: pape_francois.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
# gm10 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: pape_francois.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
# gm11 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: pape_francois.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
# gm12 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: maxime.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
# gm13 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: maxime.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
# gm14 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: maxime.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
# puts "----- Games created"

# ## game participations for fberger / xavier_niel
# gm1p = GameParticipation.create(game_id: gm1.id, user_id: xavier_niel.id, score: 42, status: "played", is_winner: true)
# gm2p = GameParticipation.create(game_id: gm1.id, user_id: fberger.id, score: 0, status: "played", is_winner: false)
# #
# gm3p = GameParticipation.create(game_id: gm2.id, user_id: xavier_niel.id, score: 42, status: "played", is_winner: true)
# gm4p = GameParticipation.create(game_id: gm2.id, user_id: fberger.id, score: 1, status: "played", is_winner: false)
# #
# gm5p = GameParticipation.create(game_id: gm3.id, user_id: xavier_niel.id, score: 42, status: "played", is_winner: true)
# gm6p = GameParticipation.create(game_id: gm3.id, user_id: fberger.id, score: 2, status: "played", is_winner: false)
# #
# gm7p = GameParticipation.create(game_id: gm4.id, user_id: xavier_niel.id, score: 42, status: "played", is_winner: true)
# gm8p = GameParticipation.create(game_id: gm4.id, user_id: fberger.id, score: 3, status: "played", is_winner: false)
# #
# gm9p = GameParticipation.create(game_id: gm5.id, user_id: xavier_niel.id, score: 42, status: "played", is_winner: true)
# gm10p = GameParticipation.create(game_id: gm5.id, user_id: fberger.id, score: 4, status: "played", is_winner: false)
# #
# gm11p = GameParticipation.create(game_id: gm6.id, user_id: xavier_niel.id, score: 42, status: "played", is_winner: true)
# gm12p = GameParticipation.create(game_id: gm6.id, user_id: fberger.id, score: 5, status: "played", is_winner: false)
# #
# gm13p = GameParticipation.create(game_id: gm7.id, user_id: xavier_niel.id, score: 42, status: "played", is_winner: true)
# gm14p = GameParticipation.create(game_id: gm7.id, user_id: fberger.id, score: 6, status: "played", is_winner: false)

# ## game participations for maxime / pape_francois
# gm15p = GameParticipation.create(game_id: gm8.id, user_id: maxime.id, score: 1, status: "played", is_winner: true)
# gm16p = GameParticipation.create(game_id: gm8.id, user_id: pape_francois.id, score: 11, status: "played", is_winner: false)
# #
# gm17p = GameParticipation.create(game_id: gm9.id, user_id: maxime.id, score: 2, status: "played", is_winner: true)
# gm18p = GameParticipation.create(game_id: gm9.id, user_id: pape_francois.id, score: 11, status: "played", is_winner: false)
# #
# gm19p = GameParticipation.create(game_id: gm10.id, user_id: maxime.id, score: 3, status: "played", is_winner: true)
# gm20p = GameParticipation.create(game_id: gm10.id, user_id: pape_francois.id, score: 11, status: "played", is_winner: false)
# #
# gm21p = GameParticipation.create(game_id: gm11.id, user_id: maxime.id, score: 4, status: "played", is_winner: true)
# gm22p = GameParticipation.create(game_id: gm11.id, user_id: pape_francois.id, score: 11, status: "played", is_winner: false)
# #
# gm23p = GameParticipation.create(game_id: gm12.id, user_id: maxime.id, score: 5, status: "played", is_winner: true)
# gm24p = GameParticipation.create(game_id: gm12.id, user_id: pape_francois.id, score: 11, status: "played", is_winner: false)
# # gm7
# gm25p = GameParticipation.create(game_id: gm13.id, user_id: maxime.id, score: 6, status: "played", is_winner: true)
# gm26p = GameParticipation.create(game_id: gm13.id, user_id: pape_francois.id, score: 11, status: "played", is_winner: false)
# #
# gm27p = GameParticipation.create(game_id: gm14.id, user_id: maxime.id, score: 7, status: "played", is_winner: true)
# gm28p = GameParticipation.create(game_id: gm14.id, user_id: pape_francois.id, score: 11, status: "played", is_winner: false)
# puts "----- Game Participations created"


# ## Tournaments
# t1 = Tournament.create(rules: "standard rules", incentives: "the flexer", deadline: (DateTime.now + 10.seconds), status: "ended", max_nb_player: 10)
# t2 = Tournament.create(rules: "standard rules", incentives: "the noob", deadline: (DateTime.now + 10.seconds), status: "ended", max_nb_player: 10)
# t3 = Tournament.create(rules: "life game", incentives: "the big boss", deadline: (DateTime.now + 10.seconds), status: "ended", max_nb_player: 10)
# puts "----- Tournaments created"

# ## Tournaments participations
# t1p1 = TournamentParticipation.create(tournament_id: t1.id, user_id: xavier_niel.id, score: 1, nb_won_game: 1, nb_lose_game: 10, status: "played")
# t1p2 = TournamentParticipation.create(tournament_id: t1.id, user_id: pape_francois.id, score: 2, nb_won_game: 2, nb_lose_game: 3, status: "played")
# t1p3 = TournamentParticipation.create(tournament_id: t1.id, user_id: feca.id, score: 3, nb_won_game: 3, nb_lose_game: 2, status: "played")
# t1p4 = TournamentParticipation.create(tournament_id: t1.id, user_id: fberger.id, score: 10, nb_won_game: 10, nb_lose_game: 1, status: "played")

# t2p1 = TournamentParticipation.create(tournament_id: t2.id, user_id: xavier_niel.id, score: 1, nb_won_game: 1, nb_lose_game: 10, status: "played")
# t2p2 = TournamentParticipation.create(tournament_id: t2.id, user_id: pape_francois.id, score: 2, nb_won_game: 2, nb_lose_game: 3, status: "played")
# t2p3 = TournamentParticipation.create(tournament_id: t2.id, user_id: feca.id, score: 3, nb_won_game: 3, nb_lose_game: 2, status: "played")
# t2p4 = TournamentParticipation.create(tournament_id: t2.id, user_id: fberger.id, score: 10, nb_won_game: 10, nb_lose_game: 1, status: "played")

# t3p1 = TournamentParticipation.create(tournament_id: t3.id, user_id: xavier_niel.id, score: 42, nb_won_game: 10, nb_lose_game: 1, status: "played")
# t3p2 = TournamentParticipation.create(tournament_id: t3.id, user_id: pape_francois.id, score: 2, nb_won_game: 2, nb_lose_game: 3, status: "played")
# t3p3 = TournamentParticipation.create(tournament_id: t3.id, user_id: feca.id, score: 3, nb_won_game: 3, nb_lose_game: 2, status: "played")
# t3p4 = TournamentParticipation.create(tournament_id: t3.id, user_id: fberger.id, score: 10, nb_won_game: 0, nb_lose_game: 10, status: "played")
# puts "----- Tournaments participations created"

# ## User Title for the winner
# t1t1 = Title.create(tournament_id: t1.id, user_id: elon_musk.id, name: "the flexer", status: "")
# elon_musk.title_id = t1t1.id
# elon_musk.save
# #
# t2t1 = Title.create(tournament_id: t2.id, user_id: fberger.id, name: "the noob", status: "")
# fberger.title_id = t2t1.id
# fberger.save
# #
# t3t1 = Title.create(tournament_id: t3.id, user_id: xavier_niel.id, name: "the big boss", status: "")
# xavier_niel.title_id = t3t1.id
# xavier_niel.save
# puts "----- Titles created"


# # War
# #war1 = War.create(start_date: DateTime.new(2010,2,3,4,5,6,'+03:00') ,end_date: DateTime.new(2010,2,3,4,5,6,'+03:00'), prize_in_points: 500, max_unanswered_call: 10, winner_id: assemblee.id, status: "ending")
# #war2 = War.create(start_date: DateTime.new(2009,4,6,9,3,4,'+10:45') ,end_date: DateTime.new(2009,4,6,9,3,4,'+10:45'), prize_in_points: 250, max_unanswered_call: 0, winner_id: order.id, status: "ending")
# #war4 = War.create(start_date: DateTime.now ,end_date: DateTime.new(2015,1,2,3,4,5,'+23:29'), prize_in_points: 102, max_unanswered_call: 0, winner_id: order.id, status: "ending")
# #war5 = War.create(start_date: DateTime.new(2014,1,2,3,4,5,'+23:29') ,end_date: DateTime.new(2014,1,2,3,4,5,'+23:29'), prize_in_points: 666, max_unanswered_call: 0, winner_id: order.id, status: "ending")
# #war6 = War.create(start_date: DateTime.new(2014,1,2,3,4,5,'+23:29') ,end_date: DateTime.new(2021,1,2,3,4,5,'+23:29'), prize_in_points: 420, max_unanswered_call: 10, winner_id: nil, status: "ongoing")
# #
# ## War participations
# #warp1 = WarParticipation.create(guild_id: assemblee.id, war_id: war1.id, war_points: 230, has_declared_war: true, nb_unanswered_call: nil, is_winner: true, status: "ending")
# #warp2 = WarParticipation.create(guild_id: order.id, war_id: war1.id, war_points: 120, has_declared_war: false, nb_unanswered_call: nil, is_winner: false, status: "ending")
# ##
# #warp3 = WarParticipation.create(guild_id: assemblee.id, war_id: war2.id, war_points: 30, has_declared_war: true, nb_unanswered_call: nil, is_winner: false, status: "ending")
# #warp4 = WarParticipation.create(guild_id: order.id, war_id: war2.id, war_points: 423, has_declared_war: false, nb_unanswered_call: nil, is_winner: true, status: "ending")
# ##
# #warp7 = WarParticipation.create(guild_id: assemblee.id, war_id: war4.id, war_points: 350, has_declared_war: true, nb_unanswered_call: nil, is_winner: false, status: "ending")
# #warp8 = WarParticipation.create(guild_id: order.id, war_id: war4.id, war_points: 4253, has_declared_war: false, nb_unanswered_call: nil, is_winner: true, status: "ending")
# #
# ## test ongoing war qui se termine 
# #warp9 = WarParticipation.create(guild_id: assemblee.id, war_id: war6.id, war_points: 100, has_declared_war: true, nb_unanswered_call: 0, is_winner: nil, status: "ongoing")
# #warp10 = WarParticipation.create(guild_id: order.id, war_id: war6.id, war_points: 50, has_declared_war: false, nb_unanswered_call: 0, is_winner: nil, status: "ongoing")
# #assemblee.war_participation_id = warp9.id
# #assemblee.save
# #order.war_participation_id = warp10.id
# #order.save