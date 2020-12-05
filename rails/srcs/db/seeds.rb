# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
​
# destroy all objects
​
ActiveRecord::Base.connection.disable_referential_integrity do
    puts "----- TournamentParticipation.destroy_all"
    TournamentParticipation.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('tournament_participations') # to reset id back to 1
​
    puts "----- Title.destroy_all"
    Title.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('titles') # to reset id back to 1
​
    puts "----- Tournament.destroy_all"
    Tournament.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('tournaments') # to reset id back to 1
​
    puts "----- AskForWar.destroy_all"
    AskForWar.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('ask_for_wars') # to reset id back to 1
​
    puts "----- WarParticipation.destroy_all"
    WarParticipation.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('war_participations') # to reset id back to 1
​
    puts "----- WarTime.destroy_all"
    WarTime.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('war_times') # to reset id back to 1
​
    puts "----- War.destroy_all"
    War.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('wars') # to reset id back to 1
​
    puts "----- Message.destroy_all"
    Message.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('messages') # to reset id back to 1
​
    puts "----- ChannelParticipation.destroy_all"
    ChannelParticipation.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('channel_participations') # to reset id back to 1
​
    puts "----- Channel.destroy_all"
    Channel.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('channels') # to reset id back to 1
​
    puts "----- GuildParticipation.destroy_all"
    GuildParticipation.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('guild_participations') # to reset id back to 1
​
    puts "----- Guild.destroy_all"
    Guild.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('guilds') # to reset id back to 1
​
    puts "----- AskForGame.destroy_all"
    AskForGame.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('ask_for_games') # to reset id back to 1
​
    puts "----- GameParticipation.destroy_all"
    GameParticipation.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('game_participations') # to reset id back to 1
​
    puts "----- game.destroy_all"
    Game.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('games') # to reset id back to 1
​
    puts "----- Friendship.destroy_all"
    Friendship.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('friendships') # to reset id back to 1
​
    puts "----- AskForFriendship.destroy_all"
    AskForFriendship.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('ask_for_friendships') # to reset id back to 1
​
    puts "----- Session.destroy_all"
    Session.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('sessions') # to reset id back to 1
​
    puts "----- Notification.destroy_all"
    Notification.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('notifications') # to reset id back to 1
​
    puts "----- User.destroy_all"
    User.destroy_all
    ActiveRecord::Base.connection.reset_pk_sequence!('users') # to reset id back to 1
end
​
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
​
## sessions
# 
​
​
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
​
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
​
​
## guilds
assemblee = Guild.create(name: "The Assembly", anagram: "42", points: 339, is_making_war: false ,owner_id: angela_merkel.id)
order     = Guild.create(name: "The Order",    anagram: "42", points: 227, is_making_war: false, owner_id: elon_musk.id  )
puts "----- Guilds created"
​
## guild participations
# the Assemblee
ap1 = GuildParticipation.create(user_id: angela_merkel.id, guild_id: assemblee.id, is_admin: true, is_officer: false)
angela_merkel.guild_participation_id = ap1.id
angela_merkel.save
#
ap2 = GuildParticipation.create(user_id: xavier_niel.id, guild_id: assemblee.id, is_admin: false, is_officer: true)
xavier_niel.guild_participation_id = ap2.id
xavier_niel.save
​
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
​
​
## games for fberger / xavier_niel
gm1 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm2 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm3 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm4 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm5 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm6 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
gm7 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: fberger.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
​
# games for maxime / pape_francois
# gm8 = Game.create(start_date: (DateTime.now - 60.seconds), end_date: DateTime.now, context: "ladder", winner_id: pape_francois.id, war_id: nil, tournament_id: nil, channel_id: nil, status: "played")
# gm9 = Game.create(start_date: (DateTime.now - 60...