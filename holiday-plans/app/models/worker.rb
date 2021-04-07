class Worker < ApplicationRecord
  belongs_to :manager
  has_many :vacation_requests
end
