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
    .distinct
  end
end
