require 'rails_helper'

describe 'Workers can request for remaining vacation days' do
  before :each do
    @manager = Manager.create
    @worker_1 = @manager.workers.create
    @worker_2 = @manager.workers.create(vacation_days_remaining: 1)
  end
  it 'can return vacation days remaining in JSON' do
    get "/api/v1/workers/#{@worker_2.id}/vacation_days"

    expect(response.status).to eq(200)

    json_data = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(json_data[:attributes][:remaining_days]).to eq(@worker_2.vacation_days_remaining)
  end
end