class VacationRequest < ApplicationRecord
  belongs_to :worker
  validates :start_date, presence: true
  validate :start_date_cannot_be_in_the_past
  validates :end_date, presence: true

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "start date can't be in the past")
    end
  end

  def self.get_overlapping_vacation_requests(worker_request)
    where("start_date >= ? AND start_date <= ?", worker_request.start_date, worker_request.end_date)
    .or(VacationRequest
    .where("end_date >= ? AND end_date <= ?", worker_request.start_date, worker_request.end_date))
    .where("id <> ?", worker_request.id)
  end
end
