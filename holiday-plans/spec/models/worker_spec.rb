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
end
