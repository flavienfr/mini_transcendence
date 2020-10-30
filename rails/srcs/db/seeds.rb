# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# destroy all objects

puts "----- Message.destroy_all"
Message.destroy_all
puts "----- ChannelParticipation.destroy_all"
ChannelParticipation.destroy_all
puts "----- Channel.destroy_all"
Channel.destroy_all

puts "----- GuildParticipation.destroy_all"
GuildParticipation.destroy_all
puts "----- Guild.destroy_all"
Guild.destroy_all

puts "----- Friendship.destroy_all"
Friendship.destroy_all

puts "----- Session.destroy_all"
Session.destroy_all
puts "----- User.destroy_all"
User.destroy_all

# users

francis = User.create(name: "francis", avatar: "https://cdn.intra.42.fr/users/fberger.jpg", current_status: "", points: 0, is_admin: false, guild_participation_id: nil) 
yamin = User.create(name: "yamin", avatar: "https://cdn.intra.42.fr/users/ylegzoul.jpg", current_status: "", points: 0, is_admin: false, guild_participation_id: nil)
flavien = User.create(name: "flavien", avatar: "https://cdn.intra.42.fr/users/froussel.jpg", current_status: "", points: 0, is_admin: false, guild_participation_id: nil)
luc = User.create(name: "luc", avatar: "https://cdn.intra.42.fr/users/lhuang.jpg", current_status: "", points: 0, is_admin: false, guild_participation_id: nil) 
maxime = User.create(name: "maxime", avatar: "https://cdn.intra.42.fr/users/mpouzol.jpg", current_status: "", points: 0, is_admin: false, guild_participation_id: nil) 

# sessions
# can't seed session because access_token expires 2 hours after generation
# => cliquer se logger

# friendship
f1 = Friendship.create(user1_id: francis.id, user2_id: yamin.id, status: "active")
f2 = Friendship.create(user1_id: francis.id, user2_id: flavien.id, status: "active")
f3 = Friendship.create(user1_id: francis.id, user2_id: luc.id, status: "active")
f4 = Friendship.create(user1_id: francis.id, user2_id: maxime.id, status: "active")

# guilds
assemblee = Guild.create(name: "The Assemblee", anagram: "42", points: 5412, is_making_war: false ,owner_id: francis.id)
order = Guild.create(name: "The Order", anagram: "42", points: 1235, is_making_war: false, owner_id: yamin.id)

# guild participations
# Assemblee
ap1 = GuildParticipation.create(user_id: francis.id, guild_id: assemblee.id, is_admin: true, is_officer: false)
francis.guild_participation_id = ap1.id
ap2 = GuildParticipation.create(user_id: flavien.id, guild_id: assemblee.id, is_admin: false, is_officer: true)
flavien.guild_participation_id = ap2.id
# Order
op1 = GuildParticipation.create(user_id: yamin.id, guild_id: order.id, is_admin: true, is_officer: false)
yamin.guild_participation_id = op1.id
op2 = GuildParticipation.create(user_id: luc.id, guild_id: order.id, is_admin: false, is_officer: true)
luc.guild_participation_id = op2.id
op3 = GuildParticipation.create(user_id: maxime.id, guild_id: order.id, is_admin: false, is_officer: true)
maxime.guild_participation_id = op3.id