class WorkersFacade
  class << self

    def filter_worker_vacation_requests(id, status)
      worker = Worker.find(id)
      list_of_requests = worker.get_vacation_requests(status)
      list_of_statuses = list_of_requests.map do |request|
        VacationReqStatus.new(request)
      end
      filtered_requests_list = FilteredVacationReqs.new(list_of_statuses)
    end

    def get_remaining_vacation_days(id)
      worker = Worker.find(id)
      VacationDays.new(worker)
    end
  end
end