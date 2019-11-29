class UserWorkersController < ApplicationController
  def create
    @worker = Worker.find(params[:worker_id])
    @user_worker = current_user.user_workers.build(worker: @worker)
    authorize @user_worker
    if @user_worker.save
      redirect_to workers_path, notice: "Favorite worker successfully created"
    else
      render "workers/index"
    end
  end

  def destroy
    @user_worker = UserWorker.find(params[:id])
    authorize @user_worker
    @user_worker.destroy
    redirect_to workers_path, notice: "Favorite worker successfully deleted"
  end
end
