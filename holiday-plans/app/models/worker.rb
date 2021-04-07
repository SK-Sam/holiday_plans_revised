class Worker < ApplicationRecord
  belongs_to :manager
  has_many :vacation_requests

  def get_vacation_requests(status)
    return vacation_requests.order("created_at ASC") if status == nil || status == ""
    vacation_requests.where("status = ?", status).order("created_at ASC")
  end
end
