class WeightLogsController < ApplicationController
  before_action :require_authentication
  before_action :set_weight_log, only: [ :edit, :update, :destroy ]

  def index
    @weight_logs = current_user.weight_logs.recent
    @weight_log = WeightLog.new
  end

  def create
    @weight_log = current_user.weight_logs.build(weight_log_params)
    @weight_log.logged_date ||= Date.today

    if @weight_log.save
      @weight_logs = current_user.weight_logs.recent
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to weight_logs_path, notice: "Weight logged successfully." }
      end
    else
      @weight_logs = current_user.weight_logs.recent
      respond_to do |format|
        format.turbo_stream { render :create, status: :unprocessable_entity }
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @weight_log.update(weight_log_params)
      redirect_to weight_logs_path, notice: "Weight log updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @weight_log.destroy
    @weight_logs = current_user.weight_logs.recent
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to weight_logs_path, notice: "Weight log deleted successfully." }
    end
  end

  private

  def require_authentication
    unless authenticated?
      redirect_to new_session_path, alert: "Please sign in to access this page."
    end
  end

  def set_weight_log
    @weight_log = current_user.weight_logs.find(params[:id])
  end

  def weight_log_params
    params.require(:weight_log).permit(:weight, :logged_date, :notes)
  end
end
