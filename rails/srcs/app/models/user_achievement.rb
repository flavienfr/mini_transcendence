class UserAchievement < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :achievement, optional: false
end
