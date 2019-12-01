class UserWorkersController < ApplicationController
  def create
    @worker = Worker.find(params[:worker_id])
    @user_worker = current_user.user_workers.build(worker: @worker)
    authorize @user_worker
    if @user_worker.save
      respond_to do |format|
        format.html { redirect_to workers_path, notice: "Favorite worker successfully created" }
        format.js # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render "workers/index" }
        format.js # <-- idem
      end
    end
  end

  def destroy
    @user_worker = UserWorker.find(params[:id])
    authorize @user_worker
    @user_worker.destroy
    respond_to do |format|
      format.html { redirect_to workers_path, notice: "Favorite worker successfully deleted" }
      format.js # render destroy.js.erb
    end
  end
end
