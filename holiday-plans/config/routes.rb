Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get '/workers/:id/vacation_requests', to: 'workers#vacation_requests'
      get'/workers/:id/vacation_days', to: 'workers#vacation_days'
      post '/workers/:id/requests', to: 'workers#create_vacation_request'

      get '/managers/:id/vacation_requests', to: 'managers#vacation_requests'
    end
  end
end
