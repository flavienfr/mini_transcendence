class User < ApplicationRecord
    has_many :sessions, dependent: :nullify
end
