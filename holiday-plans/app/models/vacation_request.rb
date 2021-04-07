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
end
