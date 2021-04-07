require 'rails_helper'
require 'date'

RSpec.describe VacationRequest, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
  end
  describe 'Attributes' do
    it 'can instantiate with attributes' do
      manager = Manager.create
      worker = manager.workers.create

      start_date = Date.current + 1
      end_date = Date.current + 2
      vacation_request = worker.vacation_requests.create(start_date: start_date, end_date: end_date)

      expect(vacation_request.start_date).to eq(start_date)
      expect(vacation_request.end_date).to eq(end_date)
      expect(vacation_request.status).to eq("pending")
      expect(vacation_request.worker_id).to eq(worker.id)
      expect(vacation_request.resolved_by).to eq(nil)

      invalid_start_date = Date.current - 2
      invalid_end_date = Date.current - 1
      vacation_request_past = worker.vacation_requests.create(start_date: invalid_start_date, end_date: invalid_end_date)

      expect(vacation_request_past.valid?).to eq(false)
      expect(vacation_request_past.errors.messages[:start_date].first).to eq("start date can't be in the past")
    end
  end
end
