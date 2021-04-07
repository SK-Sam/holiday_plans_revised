require 'rails_helper'

describe 'Workers can create a new vacation request' do
  before :each do
    @manager = Manager.create
    @worker_1 = @manager.workers.create
    @worker_2 = @manager.workers.create(vacation_days_remaining: 1)
  end
  it 'can make a new request and return a receipt of the vacation request' do
    post "/api/v1/workers/#{@worker_1.id}/requests?start_date=2022-08-24T00:00:00.000Z&end_date=2022-08-28T00:00:00.000Z"

    vacation_request = VacationRequest.first

    expect(response.status).to eq(201)

    json_data = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(json_data[:attributes][:author]).to eq(@worker_1.id)
    expect(json_data[:attributes][:status]).to eq(vacation_request.status)
    expect(json_data[:attributes][:resolved_by]).to eq(vacation_request.resolved_by)
    expect(json_data[:attributes][:request_created_at]).to be_a(String)
    expect(json_data[:attributes][:vacation_start_date]).to be_a(String)
    expect(json_data[:attributes][:vacation_end_date]).to be_a(String)
  end
  it 'can invalidate a request for bad dates' do
    post "/api/v1/workers/#{@worker_1.id}/requests?start_date=2020-08-24T00:00:00.000Z&end_date=2020-08-28T00:00:00.000Z"

    vacation_request = VacationRequest.first

    expect(response.status).to eq(409)

    json_data = JSON.parse(response.body, symbolize_names: true)

    expect(json_data[:error]).to eq("Please check start and end date to see if they're valid.")
  end
end