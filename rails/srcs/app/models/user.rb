class User < ApplicationRecord

    # has many
    has_many :sessions, dependent: :nullify 
    has_many :channel_participations, dependent: :nullify
    has_many :channels, :through => :channel_participations
    has_many :guild_participations, dependent: :nullify 
    has_many :guilds, :through => :guild_participations
    has_many :game_participations, dependent: :nullify 
    has_many :games, :through => :game_participations
    has_many :tournament_participations, dependent: :nullify 
    has_many :tournaments, :through => :tournament_participations
    has_many :messages, dependent: :nullify 
    has_many :notifications, dependent: :nullify
    has_many :block_users, dependent: :nullify

    has_many :sent_ask_for_friendships, :class_name => 'AskForFriendship', :foreign_key => 'sender_id'
    has_many :received_ask_for_friendships, :class_name => 'AskForFriendship', :foreign_key => 'recipient_id'

    has_many :sent_friendships, :class_name => 'Friendship', :foreign_key => 'sender_id'
    has_many :received_friendships, :class_name => 'Friendship', :foreign_key => 'recipient_id'

    # has one
    has_one :watch
    has_one_time_password
    has_one_attached :photo
    
    # server side validations
    validates :name, presence: true, length: { minimum: 3 }, uniqueness: { case_sensitive: false }
    
    # class methods
    def get_match_history(status)
        data = { "games": "", "games_participations": "", "users": "" }
        games_participations = {}
        users = {}

        games = self.games.where("games.status = ?", status).order(start_date: :desc)
        data["games"] = games

        games.each do |game|
            game.game_participations.each do |game_participation|
                games_participations[game_participation.id] = game_participation
                users[game_participation.user.id] = game_participation.user
            end
        end
        data["games_participations"] = games_participations
        # puts 'data["games_participations"]', data["games_participations"]
        data["users"] = users
        # puts 'data["users"]', data["users"]
        return data
    end

    def get_friendships(status)
        data = { "friendships": "", "users": "" }
        users = {}
        # 
        sent = self.sent_friendships.where("friendships.status = ?", status)
        sent.each do |friendship|
            users[friendship.recipient_id] = User.find(friendship.recipient_id)
        end
        # 
        received = self.received_friendships.where("friendships.status = ?", status)
        received.each do |friendship|
            users[friendship.sender_id] = User.find(friendship.sender_id)
        end
        # 
        friendships = sent | received
        data["friendships"] = friendships
        data["users"] = users
        return data
    end

    def get_title()
        if (self.user_title_id)
            return UserTitle.find(self.user_title_id)
        else
            return ""
    end

end
