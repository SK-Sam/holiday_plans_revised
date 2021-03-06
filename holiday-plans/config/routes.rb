Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get '/workers/:id/vacation_requests', to: 'workers#vacation_requests'
      get'/workers/:id/vacation_days', to: 'workers#vacation_days'
      post '/workers/:id/requests', to: 'workers#create_vacation_request'

      get '/managers/:id/vacation_requests', to: 'managers#vacation_requests'
      get '/managers/worker_details/:worker_id', to: 'managers#worker_details'
      get '/managers/overlapping_requests/:vacation_request_id', to: 'managers#get_overlapping_requests'
      patch '/managers/:id/requests/:vacation_request_id', to: 'managers#approve_vacation_request'
    end
  end
end
