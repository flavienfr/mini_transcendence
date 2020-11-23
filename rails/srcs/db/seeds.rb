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

    puts "----- UserTitle.destroy_all"
    UserTitle.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('user_titles') # to reset id back to 1

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
francis = User.create(name: "francis", avatar: "https://cdn.intra.42.fr/users/fberger.jpg", current_status: "offline", points: 255, is_admin: false, guild_participation_id: nil, enabled_two_factor_auth: true) 
yamin = User.create(name: "yamin", avatar: "https://cdn.intra.42.fr/users/ylegzoul.jpg", current_status: "offline", points: 31, is_admin: false, guild_participation_id: nil)
flavien = User.create(name: "flavien", avatar: "https://cdn.intra.42.fr/users/froussel.jpg", current_status: "offline", points: 665, is_admin: false, guild_participation_id: nil)
luc = User.create(name: "luc", avatar: "https://cdn.intra.42.fr/users/lhuang.jpg", current_status: "offline", points: 52, is_admin: false, guild_participation_id: nil) 
maxime = User.create(name: "maxime", avatar: "https://cdn.intra.42.fr/users/mpouzol.jpg", current_status: "offline", points: 99, is_admin: false, guild_participation_id: nil) 
#froussel = User.create(name: "Flavien Roussel", avatar: "https://cdn.intra.42.fr/users/froussel.jpg", current_status: "offline", points: 2000, is_admin: false, guild_participation_id: nil)
fberger = User.create(student_id: 37271, name: "Francis Berger", avatar: "http://res.cloudinary.com/dwcxgy6qt/image/upload/q7jfqa4cd4q8xpnxmoz55sbmi1py", current_status: "offline", points: 36, is_admin: false, guild_participation_id: nil)
puts "----- Users created"

## sessions
# 


## ask_for_friendship
aff1 = AskForFriendship.new(sender_id: fberger.id, recipient_id: yamin.id,   status: "active")
aff2 = AskForFriendship.new(sender_id: fberger.id, recipient_id: flavien.id, status: "active")
aff3 = AskForFriendship.new(sender_id: fberger.id, recipient_id: luc.id,     status: "active")
aff4 = AskForFriendship.new(sender_id: fberger.id, recipient_id: maxime.id,  status: "active")
puts "----- AskForFriendship initialized"

## friendship
f1 = Friendship.create(sender_id: fberger.id, recipient_id: yamin.id,   status: "active")
aff1.friendship_id = f1.id
aff1.save
f2 = Friendship.create(sender_id: fberger.id, recipient_id: flavien.id, status: "active")
aff2.friendship_id = f2.id
aff2.save
f3 = Friendship.create(sender_id: fberger.id, recipient_id: luc.id,     status: "active")
aff3.friendship_id = f3.id
aff3.save
f4 = Friendship.create(sender_id: fberger.id, recipient_id: maxime.id,  status: "active")
aff4.friendship_id = f4.id
aff4.save
puts "----- Friendship created"


## guilds
assemblee = Guild.create(name: "The Assemblee", anagram: "42", points: 5412, is_making_war: false ,owner_id: francis.id)
order     = Guild.create(name: "The Order",     anagram: "42", points: 1235, is_making_war: false, owner_id: yamin.id  )
puts "----- Guilds created"

## guild participations
# the Assemblee
ap1 = GuildParticipation.create(user_id: fberger.id, guild_id: assemblee.id, is_admin: true, is_officer: false)
fberger.guild_participation_id = ap1.id
fberger.save
ap2 = GuildParticipation.create(user_id: flavien.id, guild_id: assemblee.id, is_admin: false, is_officer: true)
flavien.guild_participation_id = ap2.id
flavien.save
# the Order
op1 = GuildParticipation.create(user_id: yamin.id, guild_id: order.id, is_admin: true, is_officer: false)
yamin.guild_participation_id = op1.id
yamin.save
op2 = GuildParticipation.create(user_id: luc.id, guild_id: order.id, is_admin: false, is_officer: true)
luc.guild_participation_id = op2.id
luc.save
op3 = GuildParticipation.create(user_id: maxime.id, guild_id: order.id, is_admin: false, is_officer: true)
maxime.guild_participation_id = op3.id
maxime.save
puts "----- Guild Participations created"


## games
gm1 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm2 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm3 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm4 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm5 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm6 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm7 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
puts "----- Games created"

## game participations
gm1p = GameParticipation.create(game_id: gm1.id, user_id: flavien.id, score: 1, status: "played", is_winner: false)
gm2p = GameParticipation.create(game_id: gm1.id, user_id: fberger.id, score: 2, status: "played", is_winner: true)
#
gm3p = GameParticipation.create(game_id: gm2.id, user_id: flavien.id, score: 3, status: "played", is_winner: false)
gm4p = GameParticipation.create(game_id: gm2.id, user_id: fberger.id, score: 4, status: "played", is_winner: true)
#
gm5p = GameParticipation.create(game_id: gm3.id, user_id: flavien.id, score: 5, status: "ongoing", is_winner: false)
gm6p = GameParticipation.create(game_id: gm3.id, user_id: fberger.id, score: 6, status: "ongoing", is_winner: false)
#
gm7p = GameParticipation.create(game_id: gm4.id, user_id: flavien.id, score: 7, status: "ongoing", is_winner: false)
gm8p = GameParticipation.create(game_id: gm4.id, user_id: fberger.id, score: 8, status: "ongoing", is_winner: false)
#
gm9p = GameParticipation.create(game_id: gm5.id, user_id: flavien.id, score: 9, status: "ongoing", is_winner: false)
gm10p = GameParticipation.create(game_id: gm5.id, user_id: fberger.id, score: 10, status: "ongoing", is_winner: false)
#
gm11p = GameParticipation.create(game_id: gm6.id, user_id: flavien.id, score: 11, status: "ongoing", is_winner: false)
gm12p = GameParticipation.create(game_id: gm6.id, user_id: fberger.id, score: 12, status: "ongoing", is_winner: false)
puts "----- Game Participations created"













# War
#war1 = War.create(start_date: DateTime.new(2010,2,3,4,5,6,'+03:00') ,end_date: DateTime.new(2010,2,3,4,5,6,'+03:00'), prize_in_points: 500, max_unanswered_call: 10, winner_id: assemblee.id, status: "ending")
#war2 = War.create(start_date: DateTime.new(2009,4,6,9,3,4,'+10:45') ,end_date: DateTime.new(2009,4,6,9,3,4,'+10:45'), prize_in_points: 250, max_unanswered_call: 0, winner_id: order.id, status: "ending")
#war4 = War.create(start_date: DateTime.now ,end_date: DateTime.new(2015,1,2,3,4,5,'+23:29'), prize_in_points: 102, max_unanswered_call: 0, winner_id: order.id, status: "ending")
#war5 = War.create(start_date: DateTime.new(2014,1,2,3,4,5,'+23:29') ,end_date: DateTime.new(2014,1,2,3,4,5,'+23:29'), prize_in_points: 666, max_unanswered_call: 0, winner_id: order.id, status: "ending")
#war6 = War.create(start_date: DateTime.new(2014,1,2,3,4,5,'+23:29') ,end_date: DateTime.new(2021,1,2,3,4,5,'+23:29'), prize_in_points: 420, max_unanswered_call: 10, winner_id: nil, status: "ongoing")
#
## War participations
#warp1 = WarParticipation.create(guild_id: assemblee.id, war_id: war1.id, war_points: 230, has_declared_war: true, nb_unanswered_call: nil, is_winner: true, status: "ending")
#warp2 = WarParticipation.create(guild_id: order.id, war_id: war1.id, war_points: 120, has_declared_war: false, nb_unanswered_call: nil, is_winner: false, status: "ending")
##
#warp3 = WarParticipation.create(guild_id: assemblee.id, war_id: war2.id, war_points: 30, has_declared_war: true, nb_unanswered_call: nil, is_winner: false, status: "ending")
#warp4 = WarParticipation.create(guild_id: order.id, war_id: war2.id, war_points: 423, has_declared_war: false, nb_unanswered_call: nil, is_winner: true, status: "ending")
##
#warp7 = WarParticipation.create(guild_id: assemblee.id, war_id: war4.id, war_points: 350, has_declared_war: true, nb_unanswered_call: nil, is_winner: false, status: "ending")
#warp8 = WarParticipation.create(guild_id: order.id, war_id: war4.id, war_points: 4253, has_declared_war: false, nb_unanswered_call: nil, is_winner: true, status: "ending")
#
## test ongoing war qui se termine 
#warp9 = WarParticipation.create(guild_id: assemblee.id, war_id: war6.id, war_points: 100, has_declared_war: true, nb_unanswered_call: 0, is_winner: nil, status: "ongoing")
#warp10 = WarParticipation.create(guild_id: order.id, war_id: war6.id, war_points: 50, has_declared_war: false, nb_unanswered_call: 0, is_winner: nil, status: "ongoing")
#assemblee.war_participation_id = warp9.id
#assemblee.save
#order.war_participation_id = warp10.id
#order.save