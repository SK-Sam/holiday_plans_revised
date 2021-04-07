class RemainingVacationDaysSerializer
  include FastJsonapi::ObjectSerializer
  attributes :remaining_vacation_days
  set_id {nil}
end
