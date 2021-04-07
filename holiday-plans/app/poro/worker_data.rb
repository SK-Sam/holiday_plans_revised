class WorkerData
  attr_reader :id,
              :vacation_days_remaining,
              :requests_remaining,
              :hired_at
              
  def initialize(worker)
    @id = worker.id
    @vacation_days_remaining = worker.vacation_days_remaining
    @requests_remaining = worker.requests_remaining
    @hired_at = worker.created_at
  end
end