class Api::V1::ManagersController < ApplicationController
  
  def vacation_requests
    filtered_workers_vacation_requests = ManagersFacade.filter_workers_vacation_requests(params[:id], params[:status])
    render json: WorkerRequestsSerializer.new(filtered_workers_vacation_requests)
  end
end