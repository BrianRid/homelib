class WorkersController < ApplicationController
  def index
    @workers = policy_scope(Worker)
  end
end
