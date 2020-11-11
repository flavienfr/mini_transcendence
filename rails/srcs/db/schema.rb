# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_10_191142) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievements", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ask_for_friendships", force: :cascade do |t|
    t.integer "from_user_id"
    t.integer "to_user_id"
    t.bigint "friendship_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["friendship_id"], name: "index_ask_for_friendships_on_friendship_id"
  end

  create_table "ask_for_games", force: :cascade do |t|
    t.integer "from_user_id"
    t.integer "to_user_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ask_for_wars", force: :cascade do |t|
    t.integer "from_guild_id"
    t.integer "to_guild_id"
    t.text "terms"
    t.boolean "includes_ladder"
    t.bigint "war_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "count_all_matchs_for_war", default: false
    t.index ["war_id"], name: "index_ask_for_wars_on_war_id"
  end

  create_table "channel_participations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "channel_id", null: false
    t.boolean "is_owner"
    t.boolean "is_admin"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "unmute_datetime"
    t.index ["channel_id"], name: "index_channel_participations_on_channel_id"
    t.index ["user_id"], name: "index_channel_participations_on_user_id"
  end

  create_table "channels", force: :cascade do |t|
    t.string "name"
    t.string "scope"
    t.string "password"
    t.integer "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "user1_id"
    t.integer "user2_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "game_participations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.integer "score"
    t.boolean "is_winner"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_game_participations_on_game_id"
    t.index ["user_id"], name: "index_game_participations_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "context"
    t.integer "winner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "war_id"
    t.bigint "war_time_id"
    t.bigint "tournament_id"
    t.bigint "channel_id"
    t.index ["channel_id"], name: "index_games_on_channel_id"
    t.index ["tournament_id"], name: "index_games_on_tournament_id"
    t.index ["war_id"], name: "index_games_on_war_id"
    t.index ["war_time_id"], name: "index_games_on_war_time_id"
  end

  create_table "guild_participations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "guild_id", null: false
    t.boolean "is_admin"
    t.boolean "is_officer"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.index ["guild_id"], name: "index_guild_participations_on_guild_id"
    t.index ["user_id"], name: "index_guild_participations_on_user_id"
  end

  create_table "guilds", force: :cascade do |t|
    t.string "name"
    t.string "anagram"
    t.integer "points"
    t.boolean "is_making_war"
    t.integer "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "war_participation_id"
    t.index ["war_participation_id"], name: "index_guilds_on_war_participation_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "channel_id", null: false
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel_id"], name: "index_messages_on_channel_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "from_user_id"
    t.integer "to_channel_id"
    t.integer "to_guild_id"
    t.string "message"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "table_id"
    t.string "table_type"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "timeout"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "access_token"
    t.string "token_type"
    t.string "expires_in"
    t.string "refresh_token"
    t.string "scope"
    t.boolean "need_two_factor_auth_validation", default: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "tournament_participations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tournament_id", null: false
    t.string "status"
    t.integer "score"
    t.integer "nb_won_game"
    t.integer "nb_lose_game"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tournament_id"], name: "index_tournament_participations_on_tournament_id"
    t.index ["user_id"], name: "index_tournament_participations_on_user_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "rules"
    t.string "incentives"
    t.string "status"
    t.datetime "deadline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.integer "max_nb_player"
  end

  create_table "user_achievements", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "achievement_id", null: false
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["achievement_id"], name: "index_user_achievements_on_achievement_id"
    t.index ["user_id"], name: "index_user_achievements_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "avatar"
    t.string "current_status"
    t.integer "points"
    t.boolean "is_admin", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "guild_participation_id"
    t.string "otp_secret_key"
    t.boolean "enabled_two_factor_auth", default: false
    t.integer "student_id"
    t.index ["guild_participation_id"], name: "index_users_on_guild_participation_id"
  end

  create_table "war_participations", force: :cascade do |t|
    t.bigint "guild_id"
    t.bigint "war_id"
    t.integer "war_points"
    t.boolean "has_declared_war"
    t.integer "nb_unanswered_call"
    t.boolean "is_winner"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["guild_id"], name: "index_war_participations_on_guild_id"
    t.index ["war_id"], name: "index_war_participations_on_war_id"
  end

  create_table "war_times", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "ongoing_match"
    t.integer "a"
    t.integer "b"
    t.integer "nb_unanswered_call_a"
    t.integer "nb_unanswered_call_b"
    t.bigint "war_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["war_id"], name: "index_war_times_on_war_id"
  end

  create_table "wars", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "prize_in_points"
    t.integer "max_unanswered_call"
    t.integer "winner_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "ask_for_friendships", "friendships"
  add_foreign_key "ask_for_wars", "wars"
  add_foreign_key "channel_participations", "channels"
  add_foreign_key "channel_participations", "users"
  add_foreign_key "game_participations", "games"
  add_foreign_key "game_participations", "users"
  add_foreign_key "games", "channels"
  add_foreign_key "games", "tournaments"
  add_foreign_key "games", "war_times"
  add_foreign_key "games", "wars"
  add_foreign_key "guild_participations", "guilds"
  add_foreign_key "guild_participations", "users"
  add_foreign_key "guilds", "war_participations"
  add_foreign_key "messages", "channels"
  add_foreign_key "messages", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "tournament_participations", "tournaments"
  add_foreign_key "tournament_participations", "users"
  add_foreign_key "user_achievements", "achievements"
  add_foreign_key "user_achievements", "users"
  add_foreign_key "users", "guild_participations"
  add_foreign_key "war_participations", "guilds"
  add_foreign_key "war_participations", "wars"
  add_foreign_key "war_times", "wars"
end
