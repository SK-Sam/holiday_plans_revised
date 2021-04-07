class Api::V1::ManagersController < ApplicationController
  
  def vacation_requests
    filtered_workers_vacation_requests = ManagersFacade.filter_workers_vacation_requests(params[:id], params[:status])
    render json: WorkerRequestsSerializer.new(filtered_workers_vacation_requests)
  end

  def worker_details
    worker = Worker.find(params[:worker_id])
    worker_data = WorkerData.new(worker)
    render json: WorkerOverviewSerializer.new(worker_data)
  end

  def approve_vacation_request
    vacation_request = VacationRequest.find(params[:vacation_request_id])
    manager = Manager.find(params[:id])
    vacation_request.update(status: params[:status], resolved_by: manager.id)

    render json: {message: "Status updated to #{vacation_request.status}"}, status: 204
  end

  def get_overlapping_requests
    overlapping_days = Manager.get_overlapping_vacation_requests
    render json: overlapping_days
  end
end