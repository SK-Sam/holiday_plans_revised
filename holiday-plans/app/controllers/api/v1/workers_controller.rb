class Api::V1::WorkersController < ApplicationController

  def vacation_requests
    worker = Worker.find(params[:id])
    list_of_requests = worker.get_vacation_requests(params[:status])
    list_of_statuses = list_of_requests.map do |request|
      VacationReqStatus.new(request)
    end
    filtered_requests_list = FilteredVacationReqs.new(list_of_statuses)
    render json: WorkerRequestsSerializer.new(filtered_requests_list)
  end
end