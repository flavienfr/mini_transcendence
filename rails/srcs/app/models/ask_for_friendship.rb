class AskForFriendship < ApplicationRecord
  belongs_to :friendship
  belongs_to :sender, :class_name => 'User'
  belongs_to :recipient, :class_name => 'User'
end
