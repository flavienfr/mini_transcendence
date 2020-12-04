class Channel < ApplicationRecord
    has_many :channel_participations, dependent: :nullify
    has_many :users, :through => :channel_participations
    has_many :messages, dependent: :nullify
    has_many :games, dependent: :nullify

    validates :name, presence: true, length: {minimum: 1, maximum: 25}, format: {with: /\A[A-Za-z0-9 ]+\z/}, if: Proc.new{|channel| channel.scope != "direct"}
    validates :scope, presence: true, inclusion: { in: ["protected-group", "private-group", "public-group", "direct"] }
    validates :password, presence: true, length: {minimum: 1}, if: Proc.new{|channel| channel.scope == "protected-group"}
end
