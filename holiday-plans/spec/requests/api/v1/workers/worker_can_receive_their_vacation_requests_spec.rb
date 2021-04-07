require 'rails_helper'

describe 'Workers can request for a list of their vacation requests' do
  before :each do
    @manager = Manager.create
    @worker_1 = @manager.workers.create
    @worker_2 = @manager.workers.create

    @wk1_vacation_requests_1 = @worker_1.vacation_requests.create(start_date: Date.today + 20, end_date: Date.today + 30)
    @wk1_vacation_requests_2 = @worker_1.vacation_requests.create(start_date: Date.today + 25, end_date: Date.today + 35)

    @wk2_vacation_requests_1 = @worker_2.vacation_requests.create(start_date: Date.today + 1, end_date: Date.today + 3)
    @wk2_vacation_requests_2 = @worker_2.vacation_requests.create(start_date: Date.today + 2, end_date: Date.today + 4)
  end
  it 'can return an array of their own vacation requests' do
    get "/api/v1/workers/#{@worker_1.id}/vacation_requests"

    expect(response.status).to eq(200)

    json_data = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(json_data[:attributes][:requests]).to be_an(Array)
    expect(json_data[:attributes][:requests].size).to eq(2)
    expect(json_data[:attributes][:requests].first.has_value?(@wk2_vacation_requests_1.id)).to eq(false)
    expect(json_data[:attributes][:requests].last.has_value?(@wk2_vacation_requests_1.id)).to eq(false)
    expect(json_data[:attributes][:requests].first.has_value?(@wk1_vacation_requests_1.id)).to eq(true)
  end
  it 'can be filtered to check for a specific type of status' do
    get "/api/v1/workers/#{@worker_1.id}/vacation_requests?status=approved"

    expect(response.status).to eq(200)

    json_data = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(json_data[:attributes][:requests]).to be_an(Array)
    expect(json_data[:attributes][:requests].size).to eq(0)
  end
end