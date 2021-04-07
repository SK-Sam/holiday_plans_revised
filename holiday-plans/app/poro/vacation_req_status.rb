class VacationReqStatus
  attr_reader :id,
              :author,
              :status,
              :resolved_by,
              :request_created_at,
              :vacation_start_date,
              :vacation_end_date

  def initialize(vacation_request, manager_id=nil)
    @id = vacation_request.id
    @author = vacation_request.worker_id
    @status = vacation_request.status
    @resolved_by = manager_id
    @request_created_at = vacation_request.created_at.iso8601
    @vacation_start_date = vacation_request.start_date.iso8601
    @vacation_end_date = vacation_request.end_date.iso8601
  end
end