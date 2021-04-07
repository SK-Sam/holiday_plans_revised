class VacationDays
  attr_reader :remaining_vacation_days
  def initialize(worker)
    @remaining_vacation_days = worker.vacation_days_remaining
  end
end