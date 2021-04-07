class Manager < ApplicationRecord
  has_many :workers

  def get_vacation_requests(status)
    return VacationRequest.joins(worker: :vacation_requests)
    .where("workers.manager_id = ?", self.id)
    .order("created_at ASC")
    .distinct if status == nil || status == "rejected" || status == ""

    VacationRequest.joins(worker: :vacation_requests)
    .where("workers.manager_id = ?", self.id)
    .where("vacation_requests.status = ?", status)
    .order("created_at ASC")
    .order("created_at ASC")
    .distinct
  end

  def get_overlapping_vacation_requests
    sql = "SELECT day_1.* FROM vacation_requests day_1 WHERE EXISTS(
      SELECT 1 FROM vacation_requests day_2 WHERE
      tstzrange(day_2.start_date, day_2.end_date, '[]') &&
      tstzrange(day_1.start_date, day_1.end_date, '[]')
      AND day_2.id <> day_1.id
      );"
    ActiveRecord::Base.connection.execute(sql).values
  end
end
