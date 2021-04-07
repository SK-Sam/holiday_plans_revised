class WorkerOverviewSerializer
  include FastJsonapi::ObjectSerializer
  attributes :vacation_days_remaining, :requests_remaining, :hired_at
end
