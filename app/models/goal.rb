class Goal < ApplicationRecord
  belongs_to :note
  TYPES = %w(ShortTermGoal, LongTermGoal)
end
