class UserAchievement < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :achievement, optional: true
end
