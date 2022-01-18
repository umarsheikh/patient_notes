class Note < ApplicationRecord
  has_many :short_term_goals
  has_many :long_term_goals
  has_many :goals
  after_save :handle_goals

  STATES = %w(published draft)

  def handle_goals
    short_term_goals = []
    long_term_goals = []
    description.split("\n").each do |line|
      if short_term_goal?(line)
        short_term_goals << goal_title(line)
      elsif long_term_goal?(line)
        long_term_goals << goal_title(line)
      end
    end
    goals = create_goals(short_term_goals, long_term_goals)
    delete_other_goals(goals)
  end

  private

  def published?
    state == 'published'
  end

  def delete_other_goals(current_goals)
    goals.each do |goal|
      unless current_goals.index(goal)
        goal.destroy
      end
    end
  end

  def draft?
    state == 'draft'
  end

  def short_term_goal?(line)
    line.downcase.match?(/^stg/)
  end

  def long_term_goal?(line)
    line.downcase.match?(/^ltg/)
  end

  def goal_title(line)
    line.split(':')[1].strip
  end

  def create_goals(short_term_goals, long_term_goals)
    short_term_goals = short_term_goals.collect { |t| ShortTermGoal.find_or_create_by(note_id: id, title: t)}
    long_term_goals = long_term_goals.collect { |t| LongTermGoal.find_or_create_by(note_id: id, title: t)}
    short_term_goals + long_term_goals
  end
end
