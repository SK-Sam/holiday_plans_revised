class Api::V1::WorkersController < ApplicationController

  def vacation_requests
    filtered_workers_request_list = WorkersFacade.filter_worker_vacation_requests(params[:id], params[:status])
    render json: WorkerRequestsSerializer.new(filtered_workers_request_list)
  end

  def vacation_days
    render json: RemainingVacationDaysSerializer.new(
      WorkersFacade.get_remaining_vacation_days(params[:id])
    )
  end
end