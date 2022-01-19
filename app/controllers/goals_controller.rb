class GoalsController < ApplicationController

  # GET /goals or /goals.json
  def index
    @goals = Goal.all
  end
end
