class WorkersController < ApplicationController
  def index
    @workers = policy_scope(Worker)
    # @user_worker = UserWorker.new
  end
end
