require 'rails_helper'

describe 'Manager can see all existing workers overlapping vacation requests based on a vacation request' do
  before :each do
    @manager = Manager.create
    @worker = @manager.workers.create

    @req_1 = @worker.vacation_requests.create(start_date: Date.today + 20, end_date: Date.today + 25)
    @req_2 = @worker.vacation_requests.create(start_date: Date.today + 24, end_date: Date.today + 27)
    @worker.vacation_requests.create(start_date: Date.today + 24, end_date: Date.today + 28)

    @worker.vacation_requests.create(start_date: Date.today + 26, end_date: Date.today + 28)
    @worker.vacation_requests.create(start_date: Date.today + 27, end_date: Date.today + 28)
  end
  it 'can return all of the overlapping workers vacation requests in JSON' do
    get "/api/v1/managers/overlapping_requests/#{@req_1.id}"

    expect(response.status).to eq(200)

    json_data = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(json_data[:attributes][:overlaps].size).to eq(2)
  end
end