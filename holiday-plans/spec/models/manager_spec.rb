require 'rails_helper'

RSpec.describe Manager, type: :model do
  describe 'Relationships' do
    it { should have_many :workers }
  end
  describe 'Instance Methods' do
    it '#get_vacation_requests' do
      manager = Manager.create
      worker = manager.workers.create

      worker.vacation_requests.create(start_date: Date.today + 20, end_date: Date.today + 25)
      worker.vacation_requests.create(start_date: Date.today + 30, end_date: Date.today + 37)
      worker.vacation_requests.create(start_date: Date.today + 24, end_date: Date.today + 28)

      expect(manager.get_vacation_requests(nil).size).to eq(3)
      expect(manager.get_vacation_requests(nil).first).to be_a(VacationRequest)

      expect(manager.get_vacation_requests("pending").size).to eq(3)
      expect(manager.get_vacation_requests("approved").size).to eq(0)
    end
  end
end