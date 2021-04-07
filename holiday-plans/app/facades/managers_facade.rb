class ManagersFacade
  class << self
    def filter_workers_vacation_requests(id, status)
      manager = Manager.find(id)
      list_of_requests = manager.get_vacation_requests(status)
      list_of_statuses = list_of_requests.map do |request|
        VacationReqStatus.new(request)
      end
      filtered_requests_list = FilteredVacationReqs.new(list_of_statuses)
    end

  end
end