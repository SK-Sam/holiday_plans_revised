require 'rails_helper'

describe 'Manager can request for their workers vacation requests' do
  before :each do
    @manager = Manager.create
    @worker_1 = @manager.workers.create
    @worker_2 = @manager.workers.create(vacation_days_remaining: 1)
    
    @worker_1.vacation_requests.create(start_date: Date.today + 20, end_date: Date.today + 25)
    @worker_1.vacation_requests.create(start_date: Date.today + 20, end_date: Date.today + 25)
    @worker_2.vacation_requests.create(start_date: Date.today + 20, end_date: Date.today + 25)
    @worker_2.vacation_requests.create(start_date: Date.today + 30, end_date: Date.today + 35)
  end
  it 'can return all of the managers workers vacation requests in JSON' do
    get "/api/v1/managers/#{@manager.id}/vacation_requests"

    expect(response.status).to eq(200)

    json_data = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(json_data[:attributes][:requests].size).to eq(4)
    expect(json_data[:attributes][:requests].first).to have_key(:vacation_start_date)
  end
  it 'can filter workers vacation requests based on status filter' do
    get "/api/v1/managers/#{@manager.id}/vacation_requests?status=approved"

    expect(response.status).to eq(200)

    json_data = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(json_data[:attributes][:requests].size).to eq(0)
  end
end