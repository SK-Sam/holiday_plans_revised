class VacationRequestSerializer
  include FastJsonapi::ObjectSerializer
  attributes :author, :status, :resolved_by, :request_created_at, :vacation_start_date, :vacation_end_date
end
