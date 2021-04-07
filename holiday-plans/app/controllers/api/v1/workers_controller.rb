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

  def create_vacation_request
    vacation_request = WorkersFacade.create_worker_vacation_request(
      params[:id], params[:start_date], params[:end_date]
    )
    if vacation_request.save
      vacation_request_status = VacationReqStatus.new(vacation_request)
      render json: VacationRequestSerializer.new(vacation_request_status), status: :created
    else
      render json: {error: "Please check start and end date to see if they're valid."}, status: 409
    end
  end
end