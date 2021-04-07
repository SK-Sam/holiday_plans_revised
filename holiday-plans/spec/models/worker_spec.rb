require 'rails_helper'

RSpec.describe Worker, type: :model do
  describe 'Attributes' do
    it 'can instantiate with attributes' do
      manager = Manager.create
      worker = manager.workers.create

      expect(worker.vacation_days_remaining).to eq(28)
      expect(worker.requests_remaining).to eq(30)
      expect(worker.manager_id).to eq(manager.id)
    end
  end

  describe 'Instance Method Tests' do
    it '#get_vacation_requests' do
      manager = Manager.create
      worker = manager.workers.create

      worker.vacation_requests.create(start_date: Date.today + 20, end_date: Date.today + 25)
      worker.vacation_requests.create(start_date: Date.today + 30, end_date: Date.today + 37)
      worker.vacation_requests.create(start_date: Date.today + 24, end_date: Date.today + 28)

      expect(worker.get_vacation_requests(nil).size).to eq(3)
      expect(worker.get_vacation_requests(nil).first).to be_a(VacationRequest)

      expect(worker.get_vacation_requests("pending").size).to eq(3)
      expect(worker.get_vacation_requests("approved").size).to eq(0)
    end
  end
end
