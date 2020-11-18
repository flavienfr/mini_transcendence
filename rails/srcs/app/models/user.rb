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
        return self.games.where("games.status = ?", status).order(start_date: :desc)
    end

    def get_friendships(status)
        sent = self.sent_friendships.where("friendships.status = ?", status)
        received = self.received_friendships.where("friendships.status = ?", status)
        data = sent | received
        return data
    end

end
