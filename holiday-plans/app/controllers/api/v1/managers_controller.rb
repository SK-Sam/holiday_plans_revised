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
end